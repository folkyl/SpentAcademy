import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spentacademy/pages/notes/add_note.dart';
import 'dart:math' as math;
import 'package:spentacademy/pages/quiz/quiz_overview.dart';

// MODEL
class QuizQuestion {
  final String? imageUrl;
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    this.imageUrl,
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

// CONTROLLER
class QuizController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswer = (-1).obs;
  var isAnswered = false.obs;
  var score = 0.obs;
  List<bool> userAnswers = [];

  final List<QuizQuestion> questions = [
    QuizQuestion(
      imageUrl: "assets/images/force_formula.png",
      question: "What is the name of the formula above?",
      options: [
        "Force Formula",
        "Energy Formula",
        "Electricity Formula",
        "Mass Formula"
      ],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: "What is the main product of photosynthesis?",
      options: [
        "Oxygen and water",
        "Carbon dioxide and water",
        "Glucose and oxygen",
        "Water and sunlight"
      ],
      correctIndex: 2,
    ),
    QuizQuestion(
      imageUrl: "assets/images/energy_formula.png",
      question: "What is the name of the formula above?",
      options: [
        "Force Formula",
        "Energy Formula",
        "Momentum Formula",
        "Power Formula"
      ],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: "What is the SI unit of electric current?",
      options: [
        "Volt",
        "Watt",
        "Ampere",
        "Ohm"
      ],
      correctIndex: 2,
    ),
    QuizQuestion(
      imageUrl: "assets/images/velocity_formula.png",
      question: "What does this formula calculate?",
      options: [
        "Acceleration",
        "Velocity",
        "Force",
        "Energy"
      ],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: "What is the acceleration due to gravity on Earth?",
      options: [
        "8.9 m/s²",
        "9.8 m/s²",
        "10.2 m/s²",
        "11.5 m/s²"
      ],
      correctIndex: 1,
    ),
    QuizQuestion(
      imageUrl: "assets/images/power_formula.png",
      question: "This formula is used to calculate:",
      options: [
        "Energy",
        "Force",
        "Power",
        "Momentum"
      ],
      correctIndex: 2,
    ),
    QuizQuestion(
      question: "What type of wave is light?",
      options: [
        "Mechanical wave",
        "Sound wave",
        "Electromagnetic wave",
        "Water wave"
      ],
      correctIndex: 2,
    ),
    QuizQuestion(
      imageUrl: "assets/images/ohms_law.png",
      question: "What law does this formula represent?",
      options: [
        "Newton's Law",
        "Ohm's Law",
        "Faraday's Law",
        "Coulomb's Law"
      ],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: "What is the speed of light in vacuum?",
      options: [
        "3 × 10⁸ m/s",
        "2 × 10⁸ m/s",
        "4 × 10⁸ m/s",
        "1 × 10⁸ m/s"
      ],
      correctIndex: 0,
    ),
  ];

  void selectAnswer(int index) {
    if (!isAnswered.value) {
      selectedAnswer.value = index;
      isAnswered.value = true;
      bool isCorrect = index == currentQuestion.correctIndex;
      if (isCorrect) {
        score.value++;
      }
      userAnswers.add(isCorrect);
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      selectedAnswer.value = -1;
      isAnswered.value = false;
    } else {
      // Quiz selesai, ke halaman congratulations
      Get.offAll(() => CongratulationsPage());
    }
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    selectedAnswer.value = -1;
    isAnswered.value = false;
    score.value = 0;
    userAnswers.clear();
  }

  double get progress => (currentQuestionIndex.value + 1) / questions.length;
  QuizQuestion get currentQuestion => questions[currentQuestionIndex.value];
  bool get isLastQuestion => currentQuestionIndex.value == questions.length - 1;
}

// QUIZ PAGE
class QuizQuestionPage extends StatelessWidget {
  final QuizController controller = Get.find<QuizController>();
  QuizQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFAED5FC);
    const navColor = Color(0xFF133971);
    const white = Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Obx(() => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 12, right: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: navColor, size: 20),
                        onPressed: () => Navigator.pop(context),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Progress Circle
                Center(
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(
                            value: controller.progress,
                            backgroundColor: const Color(0xFFD6E8FB),
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3777C2)),
                            strokeWidth: 4,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFD6E8FB), width: 1.5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            (controller.currentQuestionIndex.value + 1).toString().padLeft(2, "0"),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3777C2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Formula Card jika ada gambar
                if (controller.currentQuestion.imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _buildFormulaImage(controller.currentQuestion.imageUrl!),
                      ),
                    ),
                  ),

                SizedBox(height: controller.currentQuestion.imageUrl != null ? 24 : 0),

                // Question Info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Question ${controller.currentQuestionIndex.value + 1} of ${controller.questions.length}",
                      style: const TextStyle(
                        color: Color(0xFF3777C2),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Main Question
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.currentQuestion.question,
                      style: const TextStyle(
                        color: Color(0xFF133971),
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Answer Options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: List.generate(controller.currentQuestion.options.length, (i) {
                      bool isSelected = controller.selectedAnswer.value == i;
                      bool isCorrect = i == controller.currentQuestion.correctIndex;
                      bool showResult = controller.isAnswered.value;

                      Color backgroundColor = white;
                      Color textColor = const Color(0xFF133971);
                      Color borderColor = Colors.transparent;
                      Widget? trailingIcon;

                      if (showResult) {
                        if (isCorrect) {
                          backgroundColor = white;
                          textColor = const Color(0xFF4CAF50);
                          borderColor = const Color(0xFF4CAF50);
                          trailingIcon = Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          );
                        } else if (isSelected && !isCorrect) {
                          backgroundColor = white;
                          textColor = const Color(0xFFE53E3E);
                          borderColor = const Color(0xFFE53E3E);
                          trailingIcon = Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53E3E),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          );
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () => controller.selectAnswer(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: borderColor, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF3777C2).withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.currentQuestion.options[i],
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                if (trailingIcon != null) trailingIcon,
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // Next Button (jika sudah dijawab)
                if (controller.isAnswered.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3777C2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          controller.isLastQuestion ? "Finish Quiz" : "Next Question",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Progress Bar Bottom
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1ECFA),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: LinearProgressIndicator(
                            value: controller.progress,
                            backgroundColor: Colors.transparent,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3777C2)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${(controller.progress * 100).toInt()}%",
                        style: const TextStyle(
                          color: Color(0xFF133971),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

// Fungsi gambar rumus (atau asset beneran kalau ada)
Widget _buildFormulaImage(String imageUrl) {
  Map<String, Widget> formulaMap = {
    "assets/images/force_formula.png": const Text(
      "F = m × a",
      style: TextStyle(
        fontSize: 36,
        fontFamily: "Times New Roman",
        fontWeight: FontWeight.w400,
        color: Color(0xFF133971),
        fontStyle: FontStyle.italic,
      ),
    ),
    "assets/images/energy_formula.png": const Text(
      "E = mc²",
      style: TextStyle(
        fontSize: 36,
        fontFamily: "Times New Roman",
        fontWeight: FontWeight.w400,
        color: Color(0xFF133971),
        fontStyle: FontStyle.italic,
      ),
    ),
    "assets/images/velocity_formula.png": const Text(
      "v = d/t",
      style: TextStyle(
        fontSize: 36,
        fontFamily: "Times New Roman",
        fontWeight: FontWeight.w400,
        color: Color(0xFF133971),
        fontStyle: FontStyle.italic,
      ),
    ),
    "assets/images/power_formula.png": const Text(
      "P = W/t",
      style: TextStyle(
        fontSize: 36,
        fontFamily: "Times New Roman",
        fontWeight: FontWeight.w400,
        color: Color(0xFF133971),
        fontStyle: FontStyle.italic,
      ),
    ),
    "assets/images/ohms_law.png": const Text(
      "V = I × R",
      style: TextStyle(
        fontSize: 36,
        fontFamily: "Times New Roman",
        fontWeight: FontWeight.w400,
        color: Color(0xFF133971),
        fontStyle: FontStyle.italic,
      ),
    ),
  };
  return formulaMap[imageUrl] ?? Container();
}

// CONGRATULATIONS PAGE
class CongratulationsPage extends StatelessWidget {
  final QuizController controller = Get.find<QuizController>();
  CongratulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFAED5FC);
    const navColor = Color(0xFF133971);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 12, right: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: navColor, size: 20),
                      onPressed: () => Get.to(() => QuizOverviewPage()),
                      splashRadius: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Progress Circle (completed)
              SizedBox(
                height: 70,
                width: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        backgroundColor: const Color(0xFFD6E8FB),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3777C2)),
                        strokeWidth: 4,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFD6E8FB), width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.check,
                        color: Color(0xFF3777C2),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Congratulations! You've made great progress by finishing the exercise.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF133971),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Achievement Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7BB3F0),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      // Achievement Icon with confetti effect
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ...List.generate(12, (index) {
                            double angle = (index * 30) * (math.pi / 180);
                            double radius = 60;
                            return Positioned(
                              left: 50 + radius * math.cos(angle) - 3,
                              top: 50 + radius * math.sin(angle) - 3,
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: index % 2 == 0 ? Colors.yellow : Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }),
                          // Main achievement circle
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D5AA0),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.orange, width: 3),
                            ),
                            child: const Icon(
                              Icons.emoji_events,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          // Badge
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "@user",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Quiz completed with ${controller.score.value}/${controller.questions.length} correct answers!",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Misal kamu punya halaman overview quiz, bisa arahkan ke sana.
                          // Ganti dengan Get.to(QuizOverviewPage()) kalau sudah ada.
                          // Untuk sementara kembali ke home.
                          Get.to(() => QuizOverviewPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3777C2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Overview",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.to(() => AddNotePage());
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          side: const BorderSide(color: Color(0xFF3777C2), width: 2),
                        ),
                        child: const Text(
                          "Take a note",
                          style: TextStyle(
                            color: Color(0xFF3777C2),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Progress Bar (100%)
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3777C2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "100%",
                      style: TextStyle(
                        color: Color(0xFF133971),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}