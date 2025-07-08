import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:presupuestos/core/config/themes/themes.dart';
import 'package:presupuestos/core/router/app_router.dart';
import 'package:presupuestos/core/dependency_injection/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init(); // Inicializando injector de dependencias.
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'presupuestos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter, 
    );
  }
}
