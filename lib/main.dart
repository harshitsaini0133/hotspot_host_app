import 'package:flutter/material.dart';
import 'package:intern_assignment/core/app_routes.dart';
import 'package:intern_assignment/core/app_theme.dart';

void main() => runApp(const InternAssignementApp());

class InternAssignementApp extends StatelessWidget {
  const InternAssignementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InternAssignementApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.experience,
      routes: AppRoutes.routes,
    );
  }
}
