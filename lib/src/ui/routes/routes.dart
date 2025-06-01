import 'package:adc/src/ui/pages/car_page.dart';
import 'package:adc/src/ui/pages/car_register_page.dart';
import 'package:adc/src/ui/pages/config.dart';
import 'package:adc/src/ui/pages/report_page.dart';
import 'package:adc/src/ui/pages/profile_page.dart';
import 'package:adc/src/ui/pages/login_page.dart';
import 'package:adc/src/ui/pages/page_home.dart';
import 'package:adc/src/ui/pages/register_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter rotas = GoRouter(
  initialLocation: '/register',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const CarRegisterPage(),
    ),
    GoRoute(
      path: '/car',
      builder: (context, state) => const CarPage(),
    ),
    GoRoute(
      path: '/reportscreen',
      builder: (context, state) => const ReportScreen(),
    ),
    // ✅ Garanta que esta linha está aqui:
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
