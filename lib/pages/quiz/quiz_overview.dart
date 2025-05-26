import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spentacademy/pages/quiz/quiz_question.dart';

class QuizOverviewPage extends StatelessWidget {
  final QuizController controller = Get.find<QuizController>();

  QuizOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Data
    int total = controller.questions.length;
    int benar = controller.score.value;
    int salah = total - benar;
    double persenBenar = (benar / total) * 100;

    // Streak logic: berapa benar berturut-turut
    int streak = 0;
    int maxStreak = 0;
    // Jika kamu sudah track jawaban per soal, ganti list ini sesuai data asli
    // Contoh simulasi: [true, false, true, true, true, false, ...]
    List<bool> answers = controller.userAnswers ?? List.generate(total, (i) => i < benar);
    for (var correct in answers) {
      if (correct) {
        streak++;
        if (streak > maxStreak) maxStreak = streak;
      } else {
        streak = 0;
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFAED5FC),
      body: SafeArea(
        child: Stack(
          children: [
            // Bottom Navigation Bar (dummy, jika ingin diaktifkan)
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: _QuizBottomNavBar(currentIndex: 1, onTap: (i){})
            // ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top back arrow
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Color(0xFF133971)),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Profile & title
                    Row(
                      children: [
                        // Profile picture
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage("assets/images/profile_placeholder.png"), // Ganti dengan path foto user
                        ),
                        SizedBox(width: 16),
                        Text(
                          "@user's performance",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xFF3777C2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28),

                    // Percentage Circle
                    Center(
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 180,
                              height: 180,
                              child: CircularProgressIndicator(
                                value: persenBenar / 100.0,
                                backgroundColor: Color(0xFFD6E8FB),
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF225685)),
                                strokeWidth: 12,
                              ),
                            ),
                            Text(
                              "${persenBenar.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 36,
                                color: Color(0xFF225685),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 36),

                    // Correct
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFF8FC7FE),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF60EF7E),
                            ),
                            child: Icon(Icons.check, color: Colors.white, size: 22),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "$benar questions answered correctly",
                              style: TextStyle(
                                color: Color(0xFF225685),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Incorrect
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFF8FC7FE),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFD6C6C),
                            ),
                            child: Icon(Icons.close, color: Colors.white, size: 22),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "$salah questions answered incorrectly",
                              style: TextStyle(
                                color: Color(0xFF225685),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Streak
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFF8FC7FE),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFEB564),
                            ),
                            child: Icon(Icons.local_fire_department, color: Colors.white, size: 22),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "$maxStreak questions answered correctly in a row",
                              style: TextStyle(
                                color: Color(0xFF225685),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Back to Homepage Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.offAllNamed('/home'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 4,
                          shadowColor: Color(0xFF3777C2).withOpacity(0.16),
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: Text(
                          "Back to Homepage",
                          style: TextStyle(
                            color: Color(0xFF225685),
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}