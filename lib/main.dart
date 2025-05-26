import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'package:spentacademy/pages/quiz/quiz_question.dart'; // pastikan path-nya sesuai

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(QuizController(), permanent: true); // inisialisasi controller sekali di awal
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