import 'package:adc/src/ui/pages/login_page.dart';
import 'package:adc/src/ui/pages/page_home.dart';
import 'package:adc/src/ui/pages/register_page.dart';
import 'package:go_router/go_router.dart';

class MyRoutes {
  final GoRouter rotas = GoRouter(initialLocation: '/login', routes: [
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
      builder: (context, state) => MyHomePage(),
    ),
  ]);
}
