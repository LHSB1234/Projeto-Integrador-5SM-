import 'package:adc/src/ui/pages/car_page.dart';
import 'package:adc/src/ui/pages/login_page.dart';
import 'package:adc/src/ui/pages/page_home.dart';
import 'package:adc/src/ui/pages/car_register_page.dart';
import 'package:adc/src/ui/pages/report_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter rotas = GoRouter(
  initialLocation: '/register',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
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
    )
  ],
);
