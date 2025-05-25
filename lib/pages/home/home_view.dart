import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

// Jangan import ProfileView atau QuizView dari sini, fokus hanya pada HomeView!
// ProfileView dan QuizView harus diimport di file routes/app_routes.dart saja, dan gunakan alias jika perlu!

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
      backgroundColor: const Color(0xFF0A4DA2),
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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  // Hanya HomeBody yang dihandle di sini
  final List<Widget> _pages = [
    const HomeBody(),
  ];

  void _onNavTap(int idx) {
    if (idx == 0) {
      setState(() => _currentIndex = 0);
    } else if (idx == 1) {
      Get.toNamed('/quiz');
    } else if (idx == 2) {
      Get.toNamed('/material');
    } else if (idx == 3) {
      Get.toNamed('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A4DA2),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

// --------------------
// ISI TAB HOME
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header bagian atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'GOOD MORNING',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          '@user',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/profile');
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Card Currently Studying
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // Kiri: Label dan topik
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Currently Studying',
                              style: TextStyle(
                                color: Color(0xBF0D47A1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF014CA1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(Icons.calculate, color: Colors.white, size: 12),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Square Root',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF002560),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Kanan: Persentase di dalam lingkaran
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: 0.86,
                              backgroundColor: const Color(0xFFE6ECF5),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF014CA1),
                              ),
                              strokeWidth: 5.0,
                            ),
                            const Text(
                              '86%',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF014CA1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Bagian "Continue"
                const Row(
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ],
                ),
                const SizedBox(height: 12),

                // Scrollable Continue Cards
                SizedBox(
                  height: 175,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      continueCard(
                        imagePath: 'assets/ball_game.png',
                        title: 'Major Ball Games',
                        questions: '20 questions',
                        progress: 0.45,
                      ),
                      continueCard(
                        imagePath: 'assets/force_motion.png',
                        title: 'Force and Motion',
                        questions: '25 questions',
                        progress: 0.62,
                      ),
                      continueCard(
                        imagePath: 'assets/chemistry.png',
                        title: 'Basic Chemistry',
                        questions: '15 questions',
                        progress: 0.35,
                      ),
                    ],
                  ),
                ),

                // Recommend Material Section
                const SizedBox(height: 24),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommend Material',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Material Card List
                Column(
                  children: [
                    recommendMaterialCard(
                      title: 'Algebra',
                      time: '13 mins reading',
                      icon: Icons.menu_book_outlined,
                    ),
                    const SizedBox(height: 12),
                    recommendMaterialCard(
                      title: 'Energy',
                      time: '13 mins reading',
                      icon: Icons.menu_book_outlined,
                    ),
                  ],
                ),

                // Studying Performance Chart Section
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF014CA1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Studying Performance',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            backgroundColor: const Color(0xFF014CA1),
                            minY: 20,
                            maxY: 90,
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  interval: 15,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      '${value.toInt()}m',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    const dates = [
                                      'Dec 5',
                                      'Dec 6',
                                      'Dec 7',
                                      'Dec 8',
                                      'Dec 9',
                                      'Dec 10'
                                    ];
                                    if (value.toInt() >= 0 &&
                                        value.toInt() < dates.length) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          dates[value.toInt()],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              verticalInterval: 1,
                              horizontalInterval: 15,
                              getDrawingHorizontalLine: (value) {
                                if (value == 60) {
                                  return const FlLine(
                                    color: Colors.white60,
                                    dashArray: [5, 5],
                                    strokeWidth: 1,
                                  );
                                }
                                return const FlLine(
                                  color: Colors.white30,
                                  strokeWidth: 1,
                                );
                              },
                              getDrawingVerticalLine: (value) {
                                return const FlLine(
                                  color: Colors.white30,
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: const [
                                  FlSpot(0, 45),
                                  FlSpot(1, 25),
                                  FlSpot(2, 48),
                                  FlSpot(3, 60),
                                  FlSpot(4, 30),
                                  FlSpot(5, 66),
                                ],
                                isCurved: false,
                                barWidth: 2,
                                color: Colors.white,
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter: (spot, percent, barData, index) {
                                    if (index == 5) {
                                      return FlDotCirclePainter(
                                        radius: 6,
                                        color: Colors.white,
                                        strokeWidth: 2,
                                        strokeColor: const Color(0xFF014CA1),
                                      );
                                    }
                                    return FlDotCirclePainter(
                                      radius: 3,
                                      color: Colors.white,
                                      strokeWidth: 1,
                                      strokeColor: Colors.white,
                                    );
                                  },
                                ),
                              )
                            ],
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Calendar Section
                const CalendarSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget untuk card "Continue"
Widget continueCard({
  required String imagePath,
  required String title,
  required String questions,
  required double progress,
}) {
  return Container(
    width: 140,
    margin: const EdgeInsets.only(right: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.image, color: Colors.grey, size: 40),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF002560),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          questions,
          style: const TextStyle(fontSize: 12, color: Color(0xFF9CA4AF)),
        ),
        const SizedBox(height: 8),
        // Hilangkan borderRadius jika Flutter-mu < 3.7
        LinearProgressIndicator(
          value: progress,
          backgroundColor: const Color(0xFFE6ECF5),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF014CA1)),
          // borderRadius: BorderRadius.circular(20), // Hapus baris ini jika error!
        ),
      ],
    ),
  );
}

Widget recommendMaterialCard({
  required String title,
  required String time,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.25),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(
                  color: Color(0xB2FFFFFF),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
      ],
    ),
  );
}

// CalendarSection tetap sama seperti sebelumnya
class CalendarSection extends StatefulWidget {
  const CalendarSection({super.key});

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, String> _notes = {
    DateTime.utc(2025, 5, 5): 'Periodic Table',
    DateTime.utc(2025, 5, 12): 'History',
    DateTime.utc(2025, 5, 18): 'Computer Science',
  };

  bool _hasNote(DateTime day) {
    final key = DateTime.utc(day.year, day.month, day.day);
    return _notes.containsKey(key);
  }

  String? _getNote(DateTime day) {
    final key = DateTime.utc(day.year, day.month, day.day);
    return _notes[key];
  }

  void _goToPrevMonth() {
    setState(() {
      _focusedDay = DateTime(
        _focusedDay.year,
        _focusedDay.month - 1,
        1,
      );
      _selectedDay = null;
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay = DateTime(
        _focusedDay.year,
        _focusedDay.month + 1,
        1,
      );
      _selectedDay = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Header bulan custom
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: _goToPrevMonth,
                  splashRadius: 18,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DateFormat.yMMMM().format(_focusedDay),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: _goToNextMonth,
                  splashRadius: 18,
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.5),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  if (selectedDay.month == _focusedDay.month && selectedDay.year == _focusedDay.year) {
                    setState(() {
                      _selectedDay = selectedDay;
                    });

                    if (_hasNote(selectedDay)) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Row(
                            children: [
                              const Icon(Icons.subject, color: Colors.black),
                              const SizedBox(width: 8),
                              Text(DateFormat.yMMMMd().format(selectedDay)),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_getNote(selectedDay)!),
                              const SizedBox(height: 16),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.subject, color: Colors.black, size: 20),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc ut laoreet dictum, urna erat cursus enim, nec dictum ex nulla ac nisi. Pellentesque habitant morbi tristique senectus et netus.',
                                      style: TextStyle(fontSize: 13, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
                headerVisible: false,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                  weekendStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                  decoration: BoxDecoration(),
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF0D47A1),
                    shape: BoxShape.circle,
                  ),
                  cellMargin: EdgeInsets.all(2),
                  cellPadding: EdgeInsets.all(0),
                  outsideTextStyle: TextStyle(color: Colors.white54),
                  defaultTextStyle: TextStyle(color: Colors.white, fontSize: 13),
                  weekendTextStyle: TextStyle(color: Colors.white, fontSize: 13),
                  selectedTextStyle: TextStyle(color: Colors.white, fontSize: 13),
                  todayTextStyle: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold, fontSize: 13),
                ),
                availableGestures: AvailableGestures.all,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) => null,
                  selectedBuilder: (context, day, focusedDay) {
                    final hasNote = _hasNote(day);
                    return Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0D47A1),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          if (hasNote)
                            Container(
                              width: 4,
                              height: 4,
                              margin: const EdgeInsets.only(top: 2),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    final hasNote = _hasNote(day);
                    return Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${day.day}',
                            style: const TextStyle(
                              color: Color(0xFF0D47A1),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          if (hasNote)
                            Container(
                              width: 4,
                              height: 4,
                              margin: const EdgeInsets.only(top: 2),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0D47A1),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    final hasNote = _hasNote(day);
                    return SizedBox(
                      width: 26,
                      height: 26,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          if (hasNote)
                            Container(
                              width: 4,
                              height: 4,
                              margin: const EdgeInsets.only(top: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    final hasNote = _hasNote(day);
                    return SizedBox(
                      width: 26,
                      height: 26,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                          if (hasNote)
                            Container(
                              width: 4,
                              height: 4,
                              margin: const EdgeInsets.only(top: 2),
                              decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}