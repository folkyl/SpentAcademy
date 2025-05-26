import 'package:get/get.dart';
import 'package:spentacademy/pages/material/material_view.dart';
import '../pages/logreg/login_view.dart';
import '../pages/logreg/register_view.dart';
import '../pages/home/home_view.dart';
import '../pages/quiz/quiz_view.dart' as quiz_page;
import '../pages/profile/profile_view.dart' as profile_page;
// import '../pages/material/material_page.dart'; // jika ada

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const quiz = '/quiz';
  static const profile = '/profile';
  static const material = '/material';

  static final pages = [
    GetPage(name: login, page: () => const LoginView()),
    GetPage(name: register, page: () => const RegisterView()),
    GetPage(name: home, page: () => const HomeView()),
    GetPage(name: quiz, page: () => quiz_page.QuizView()),
    GetPage(name: profile, page: () => const profile_page.ProfileView()),
    GetPage(name: material, page: () => const MaterialView()),
  ];
}