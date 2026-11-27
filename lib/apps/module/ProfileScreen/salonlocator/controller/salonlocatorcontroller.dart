import 'dart:convert';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_cluster_manager_2/src/cluster.dart' as custom_cluster;
import 'package:flutter_cluster_manager_2/src/cluster_item.dart' as custom_cluster;
import 'package:flutter_cluster_manager_2/src/cluster_manager.dart' as custom_cluster;
class SalonClusterItem with custom_cluster.ClusterItem {
  final Map<String, dynamic> salon;
  final LatLng latLng;
  SalonClusterItem({
    required this.salon,
    required this.latLng,
  });
  @override
  LatLng get location => latLng;
}
class Salonlocatorcontroller extends GetxController {
  final RxList<Map<String, dynamic>> salons = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredSalons = <Map<String, dynamic>>[].obs;
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxBool hasLocationPermission = false.obs;
  final RxBool isGettingLocation = false.obs;
  final Rxn<Position> currentPosition = Rxn<Position>();
  final Rxn<Map<String, dynamic>> selectedSalon = Rxn<Map<String, dynamic>>();
  final RxBool isLoading = true.obs;
  final RxString searchQuery = ''.obs;
  GoogleMapController? mapController;
  custom_cluster.ClusterManager<SalonClusterItem>? clusterManager;
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(39.8283, -98.5795), zoom: 4);
  @override
  void onInit() {
    super.onInit();
    loadSalons();
  }
  bool isSalonVisible(Map<String, dynamic> salon) {
    return salon['visible']?.toString().trim().toLowerCase() == 'yes';
  }
  Future<void> openSalonDirections(Map<String, dynamic> salon) async {
    try {
      final dynamic latitude = salon['latitude'] ?? salon['lat'];
      final dynamic longitude = salon['longitude'] ?? salon['lng'];
      if (latitude == null || longitude == null) {
        Get.snackbar(
          'Location Unavailable',
          'Directions are not available for this salon.',
        );
        return;
      }
      final double? lat = double.tryParse(latitude.toString());
      final double? lng = double.tryParse(longitude.toString());
      if (lat == null || lng == null) {
        Get.snackbar(
          'Location Unavailable',
          'This salon does not have valid coordinates.',
        );
        return;
      }
      final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/dir/?api=1'
            '&destination=$lat,$lng'
            '&travelmode=driving',
      );
      final bool launched = await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        Get.snackbar(
          'Unable to Open Maps',
          'Please try again.',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Directions Error',
        'Unable to open directions for this salon.',
      );
    }
  }
  Future<void> getCurrentLocation() async {
    if (isGettingLocation.value) return;
    try {
      isGettingLocation.value = true;
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          'Location Disabled',
          'Please enable location services on your device.',
        );
        await Geolocator.openLocationSettings();
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          'Permission Required',
          'Location permission is needed to find nearby salons.',
        );
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Permission Required',
          'Please allow location access from app settings.',
        );
        await Geolocator.openAppSettings();
        return;
      }
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );
      currentPosition.value = position;
      hasLocationPermission.value = true;
      final map = mapController;
      if (map != null) {
        await map.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                position.latitude,
                position.longitude,
              ),
              zoom: 11,
            ),
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Location Error',
        'Unable to get your current location. Please try again.',
      );
    } finally {
      isGettingLocation.value = false;
    }
  }
  bool hasValidCoordinates(Map<String, dynamic> salon) {
    final double? lat = double.tryParse(salon['latitude']?.toString() ?? '',);
    final double? lng = double.tryParse(salon['longitude']?.toString() ?? '',);
    return salon['geocoding_status'] == 'OK' &&
        lat != null &&
        lng != null &&
        lat >= -90 &&
        lat <= 90 &&
        lng >= -180 &&
        lng <= 180;
  }
  Future<void> loadSalons() async {
    try {
      isLoading.value = true;
      final response = await rootBundle.loadString('asset/data/stockist-locations-geocoded.json',);
      final Map<String, dynamic> jsonData = jsonDecode(response);
      final List<dynamic> locations = jsonData['locations'] ?? [];
      salons.assignAll(locations.map((item) => Map<String, dynamic>.from(item)).toList());
      filteredSalons.assignAll(salons.where(isSalonVisible).toList(),);
      initializeClusterManager();
    } catch (e, stackTrace) {
    } finally {
      isLoading.value = false;
    }
  }
  void initializeClusterManager() {
    final items = filteredSalons.where(hasValidCoordinates).map((salon) {
      return SalonClusterItem(
        salon: salon,
        latLng: LatLng(
          double.parse(salon['latitude'].toString()),
          double.parse(salon['longitude'].toString()),
        ),
      );
    }).toList();
    clusterManager = custom_cluster.ClusterManager<SalonClusterItem>(
      items,
      updateClusterMarkers,
      markerBuilder: buildClusterMarker,
      levels: const [
        1,
        4.25,
        6.75,
        8.25,
        11.5,
        14.5,
        16,
        16.5,
        20,
      ],
      extraPercent: 0.2,
      stopClusteringZoom: 17,
    );
    if (mapController != null) {
      clusterManager?.updateMap();
    }
  }
  void updateClusterMarkers(Set<Marker> newMarkers) {
    markers.assignAll(newMarkers);
  }
  Future<Marker> buildClusterMarker(custom_cluster.Cluster<SalonClusterItem> cluster) async {
    final bool isMultiple = cluster.isMultiple;
    final SalonClusterItem? item = isMultiple ? null : cluster.items.first;
    final bool isSelected = item != null && selectedSalon.value?['stockist_id']?.toString() == item.salon['stockist_id']?.toString();
    return Marker(
      markerId: MarkerId(cluster.getId()),
      position: cluster.location,
      icon: await createClusterIcon(
        count: cluster.count,
        isCluster: isMultiple,
        isSelected: isSelected,
      ),
      onTap: () {
        if (isMultiple) {
          final map = mapController;
          if (map != null) {
            map.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: cluster.location,
                  zoom: 9,
                ),
              ),
            );
          }
        } else if (item != null) {
          selectSalon(item.salon);
        }
      },
      infoWindow: isMultiple ? InfoWindow(
        title: '${cluster.count} salons',
      ) : InfoWindow(
        title: item?.salon['name']?.toString() ?? 'Salon',
        snippet: [
          item?.salon['city'],
          item?.salon['state_province'],
        ].where((value) =>
          value != null && value.toString().trim().isNotEmpty,
        ).join(', '),
      ),
    );
  }
  Future<BitmapDescriptor> createClusterIcon({
    required int count,
    required bool isCluster,
    required bool isSelected,
  }) async {
    const double size = 120;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final Paint circlePaint = Paint()
      ..color = isSelected
          ? Colorstheam.Racingred
          : Colorstheam.nobelblack
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      const Offset(size / 2, size / 2),
      size / 2,
      circlePaint,
    );
    if (isCluster) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: count.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: size - 10);
      textPainter.paint(
        canvas,
        Offset(
          (size - textPainter.width) / 2,
          (size - textPainter.height) / 2,
        ),
      );
    } else {
      final textPainter = TextPainter(
        text: const TextSpan(
          text: 'M',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (size - textPainter.width) / 2,
          (size - textPainter.height) / 2,
        ),
      );
    }
    final picture = recorder.endRecording();
    final image = await picture.toImage(
      size.toInt(),
      size.toInt(),
    );
    final bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    if (bytes == null) {
      return BitmapDescriptor.defaultMarker;
    }
    return BitmapDescriptor.fromBytes(
      bytes.buffer.asUint8List(),
    );
  }
  Future<void> onMapCreated(GoogleMapController map) async {
    mapController = map;
    await clusterManager?.setMapId(map.mapId);
    final salon = selectedSalon.value;
    if (salon != null) {
      focusSalon(salon);
    }
  }
  void onCameraMove(CameraPosition position) {
    clusterManager?.onCameraMove(position);
  }
  void onCameraIdle() {
    clusterManager?.updateMap();
  }
  void selectSalon(Map<String, dynamic> salon) {
    selectedSalon.value = salon;
    clusterManager?.updateMap();
    focusSalon(salon);
  }
  Future<void> focusSalon(Map<String, dynamic> salon) async {
    if (!hasValidCoordinates(salon)) return;
    final map = mapController;
    if (map == null) return;
    final lat = double.parse(salon['latitude'].toString());
    final lng = double.parse(salon['longitude'].toString());
    await map.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 14,
        ),
      ),
    );
  }
  void clearSelectedSalon() {
    selectedSalon.value = null;
    clusterManager?.updateMap();
  }
  void searchSalons(String query) {
    searchQuery.value = query;
    String normalize(String value) {
      return value
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
          .trim()
          .replaceAll(RegExp(r'\s+'), ' ');
    }
    final search = normalize(query);
    final searchWords = search
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();
    final results = salons.where((salon) {
      if (!isSalonVisible(salon)) return false;
      if (search.isEmpty) return true;
      final searchableText = normalize([
        salon['name'],
        salon['address_line_1'],
        salon['address_line_2'],
        salon['city'],
        salon['state_province'],
        salon['postal_code'],
        salon['country'],
        salon['phone'],
        salon['website'],
        salon['website_url'],
        salon['url'],
      ].where((value) => value != null).join(' '));
      return searchWords.every((word) => searchableText.contains(word));
    }).toList();
    filteredSalons.assignAll(results);
    if (search.isEmpty) {
      selectedSalon.value = null;
      initializeClusterManager();
      return;
    }
    Map<String, dynamic>? matchingSalon;
    for (final salon in results) {
      if (hasValidCoordinates(salon)) {
        matchingSalon = salon;
        break;
      }
    }
    selectedSalon.value = matchingSalon;
    initializeClusterManager();
    if (matchingSalon != null) {
      focusSalon(matchingSalon);
    }
  }
  @override
  void onClose() {
    mapController = null;
    super.onClose();
  }
}