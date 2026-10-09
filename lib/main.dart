import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/controller/wishlistcontroller.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Get.put(Nointernetcontroller(), permanent: true);
  Get.put(
    Wishlistcontroller(),
    permanent: true,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          title: "PTJ-Arena",
          defaultTransition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),
          popGesture: true,
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    );
  }
}