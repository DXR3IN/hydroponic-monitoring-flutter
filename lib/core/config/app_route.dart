import 'package:get/get.dart';
import 'package:hydroponic_mobile/main.dart';
import 'package:hydroponic_mobile/presentation/bindings/main_binding.dart';
import 'package:hydroponic_mobile/presentation/bindings/auth/login_binding.dart';
import 'package:hydroponic_mobile/presentation/bindings/auth/register_binding.dart';
import 'package:hydroponic_mobile/presentation/bindings/splash_binding.dart';
import 'package:hydroponic_mobile/presentation/bindings/welcome_binding.dart';
import 'package:hydroponic_mobile/presentation/pages/auth/login_page.dart';
import 'package:hydroponic_mobile/presentation/pages/auth/register_page.dart';
import 'package:hydroponic_mobile/presentation/pages/splash_page.dart';
import 'package:hydroponic_mobile/presentation/pages/welcome_page.dart';

class AppRoute {
  static const String defaultRoute = '/';
  static const String unknown = '/unknown';
  static const String welcomeScreen = '/welcome';
  static const String splashScreen = '/splash';
  static const String homeScreen = '/home';
  static const String detailScreen = '/detail';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';

  static List<GetPage> pages = [
    GetPage(
      name: defaultRoute,
      page: () => MainLayout(),
      binding: MainBinding(),
    ),
    GetPage(
      name: splashScreen,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: welcomeScreen,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
    // GetPage(name: homeScreen, page: () =>),
    // GetPage(name: detailScreen, page: ()=>),
    GetPage(
        name: loginScreen,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
      name: registerScreen,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    )
  ];
}
