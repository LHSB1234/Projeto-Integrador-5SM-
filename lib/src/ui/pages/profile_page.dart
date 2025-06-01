import 'package:adc/src/ui/_core/widgets/my_appbar.dart';
import 'package:adc/src/ui/_core/widgets/my_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _routes = [
    '/',
    '/car',
    '/reportscreen',
    '/profile',
    '/settings'
  ];
  int getCurrentIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final index = _routes.indexOf(location);
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Container(),
      bottomNavigationBar: MyNavigationBar(
        currentIndex: getCurrentIndex(context),
      ),
    );
  }
}
