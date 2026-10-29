
class InPersonEducationModel {
  final Map<String, dynamic> fields;

  InPersonEducationModel({required this.fields});

  factory InPersonEducationModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final Map<String, dynamic> result = {};

    for (final item in (json['fields'] as List? ?? [])) {
      if (item is! Map) continue;

      final key = item['key']?.toString();
      if (key == null) continue;

      final reference = item['reference'];
      final image = reference is Map
          ? reference['image']
          : null;

      final references = item['references'];
      final nodes = references is Map
          ? references['nodes'] as List? ?? []
          : [];

      result[key] = {
        'value': item['value']?.toString(),
        'imageUrl': image is Map
            ? image['url']?.toString()
            : null,
        'images': nodes
            .whereType<Map>()
            .map((node) {
          final nodeImage = node['image'];
          return nodeImage is Map
              ? nodeImage['url']?.toString()
              : null;
        })
            .whereType<String>()
            .toList(),
      };
    }

    return InPersonEducationModel(fields: result);
  }

  String text(String key, {String fallback = ''}) {
    return fields[key]?['value']?.toString() ?? fallback;
  }

  String? imageUrl(String key) {
    return fields[key]?['imageUrl']?.toString();
  }

  List<String> images(String key) {
    return List<String>.from(
      fields[key]?['images'] ?? const [],
    );
  }

  bool enabled(String key, {bool fallback = true}) {
    final value = fields[key]?['value']?.toString().toLowerCase();

    if (value == 'true') return true;
    if (value == 'false') return false;

    return fallback;
  }
}
