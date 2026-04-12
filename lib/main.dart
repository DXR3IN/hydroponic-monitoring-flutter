import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/core/config/app_config.dart';
import 'package:hydroponic_mobile/core/config/app_route.dart';
import 'package:hydroponic_mobile/core/config/app_style.dart';
import 'package:hydroponic_mobile/core/di/auth_module.dart';
import 'package:hydroponic_mobile/core/di/device_module.dart';
import 'package:hydroponic_mobile/core/di/telemetry_module.dart';
import 'package:hydroponic_mobile/core/network/api_client.dart';
import 'package:hydroponic_mobile/core/utils/storage_service.dart';
import 'package:hydroponic_mobile/presentation/controllers/main_controller.dart';
import 'package:hydroponic_mobile/presentation/pages/device_page.dart';
import 'package:hydroponic_mobile/presentation/pages/error/unknown_page.dart';
import 'package:hydroponic_mobile/presentation/pages/home_page.dart';
import 'package:hydroponic_mobile/presentation/pages/setting_page.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppStyle.mainColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  await AppConfig.load(AppConfig.environment);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _dependencyInjection();
  runApp(const MyApp());
}

Future<void> _dependencyInjection() async {
  // change the environment name on AppConfig to .env for production and .env-dev for development
  await Get.putAsync(() => StorageService().init(), permanent: true);
  Get.lazyPut<Dio>(() => createDioClient(), fenix: true);
  initAuthDepedencies();
  initDeviceDepedencies();
  initTelemetryDepedencies();
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: AppRoute.splashScreen,
      unknownRoute:
          GetPage(name: AppRoute.unknown, page: () => const UnknownRoutePage()),
      getPages: AppRoute.pages,
    );
  }
}

class MainLayout extends GetView<MainController> {
  MainLayout({super.key});

  final List<Widget> _screens = [
    const HomePage(),
    const DevicePage(),
    // const Center(
    // child: Text("Scenes Screen", style: TextStyle(color: Colors.grey))),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index: controller.currentIndex.value,
              children: _screens,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF9BD1D1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add, color: Color(0xFF041616), size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildCustomBottomNav(),
    );
  }

  Widget _buildCustomBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF041616),
        border: Border(top: BorderSide(color: Colors.white10, width: 1)),
      ),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navItem(icon: Icons.home_filled, label: "HOME", index: 0),
              _navItem(
                  icon: Icons.grid_view_rounded, label: "DEVICES", index: 1),
              // _navItem(icon: Icons.auto_awesome, label: "SCENES", index: 2),
              _navItem(icon: Icons.settings, label: "SETTINGS", index: 2),
            ],
          )),
    );
  }

  Widget _navItem(
      {required IconData icon, required String label, required int index}) {
    bool isActive = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index), // Panggil fungsi di controller
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF122A2A) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFF9BD1D1) : Colors.grey.shade600,
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: isActive ? const Color(0xFF9BD1D1) : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
