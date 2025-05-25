import 'package:get/get.dart';
import 'congratulations_page.dart';

// Model
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
      // Quiz completed, navigate to congratulations page first
      Get.off(() => CongratulationsPage());
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
  
  QuizQuestion get currentQuestion {
    if (currentQuestionIndex.value >= 0 && currentQuestionIndex.value < questions.length) {
      return questions[currentQuestionIndex.value];
    }
    return questions[0];
  }
  
  bool get isLastQuestion => currentQuestionIndex.value == questions.length - 1;
}