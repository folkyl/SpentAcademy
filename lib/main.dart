import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';




void main() {
  // Pastikan binding sudah siap
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpentAcademy',
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.pages,
    ); 
  }
}
