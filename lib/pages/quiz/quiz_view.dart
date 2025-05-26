import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spentacademy/pages/quiz/quiz_question.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF0D47A1),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Material'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class QuizView extends StatefulWidget {
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  int _currentIndex = 1;
  String _filter = "";

  final List<QuizItem> quizzes = [
    QuizItem(
      id: 1,
      title: "Basic Physics",
      description: "A set of basic physics questions for beginners",
      totalQuestions: 10,
      progress: 0.0,
      color: const Color(0xFF0D47A1),
      icon: Icons.science,
    ),
    QuizItem(
      id: 2,
      title: "Mathematics",
      description: "High school mathematics questions",
      totalQuestions: 1,
      progress: 0.17,
      color: const Color(0xFF0D47A1),
      icon: Icons.calculate,
    ),
    QuizItem(
      id: 3,
      title: "Organic Chemistry",
      description: "Advanced organic chemistry learning",
      totalQuestions: 1,
      progress: 0.0,
      color: const Color(0xFF0D47A1),
      icon: Icons.biotech,
    ),
    QuizItem(
      id: 4,
      title: "Biology",
      description: "Cell and molecular biology questions",
      totalQuestions: 1,
      progress: 0.0,
      color: const Color(0xFF0D47A1),
      icon: Icons.pets,
    ),
    QuizItem(
      id: 5,
      title: "Indonesian History",
      description: "History of Indonesian independence",
      totalQuestions: 1,
      progress: 0.0,
      color: const Color(0xFF0D47A1),
      icon: Icons.history_edu,
    ),
  ];

  void _onNavTap(int idx) {
    setState(() => _currentIndex = idx);

    switch (idx) {
      case 0:
        if (Get.routing.route?.settings.name != null) {
          Get.offAllNamed('/home');
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
        break;
      case 1:
        break;
      case 2:
        if (Get.routing.route?.settings.name != null) {
          Get.offAllNamed('/material');
        } else {
          Navigator.pushReplacementNamed(context, '/material');
        }
        break;
      case 3:
        if (Get.routing.route?.settings.name != null) {
          Get.offAllNamed('/profile');
        } else {
          Navigator.pushReplacementNamed(context, '/profile');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtering quizzes based on the filter string (case-insensitive)
    final filteredQuizzes = quizzes.where((quiz) {
      final filterLower = _filter.toLowerCase();
      return quiz.title.toLowerCase().contains(filterLower)
          || quiz.description.toLowerCase().contains(filterLower);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0D47A1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Quiz List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8, top: 8),
                child: Text(
                  'Choose Quiz Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              // FILTER FIELD
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search subject...",
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.search, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _filter = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: filteredQuizzes.isEmpty
                    ? const Center(
                        child: Text(
                          "No subjects found.",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: filteredQuizzes.length,
                        itemBuilder: (context, index) {
                          return QuizCard(
                            quiz: filteredQuizzes[index],
                            onTap: () => _navigateToQuiz(),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }

  void _navigateToQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizQuestionPage(),
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  final QuizItem quiz;
  final VoidCallback onTap;

  const QuizCard({
    Key? key,
    required this.quiz,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: quiz.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        quiz.icon,
                        color: quiz.color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            quiz.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: quiz.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${quiz.totalQuestions} Questions',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: quiz.color,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (quiz.progress > 0)
                      Text(
                        '${(quiz.progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: quiz.color,
                        ),
                      ),
                  ],
                ),
                if (quiz.progress > 0) ...[
                  const SizedBox(height: 8),
                  Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: quiz.progress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: quiz.color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// QuizItem model
class QuizItem {
  final int id;
  final String title;
  final String description;
  final int totalQuestions;
  final double progress;
  final Color color;
  final IconData icon;

  QuizItem({
    required this.id,
    required this.title,
    required this.description,
    required this.totalQuestions,
    required this.progress,
    required this.color,
    required this.icon,
  });
}