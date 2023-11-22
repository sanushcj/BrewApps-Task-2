import 'package:brewapps_task02/features/bottombar/mybottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/home/services/home_controller.dart';
import 'features/top_rated/services/toprated_controller.dart';
import 'routes/routes.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
  ApiServiceNowPlaying controllerNow = Get.put(ApiServiceNowPlaying());
  TopRatedController controllerTop = Get.put(TopRatedController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyBottomNavBar(),
    );
  }
}
