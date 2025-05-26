import 'package:flutter/material.dart';
import 'dart:ui';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  int _currentIndex = 0;
  int _bottomNavIndex = 3;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 50 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabChange(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onNavTap(int idx) {
    setState(() {
      _bottomNavIndex = idx;
    });
    if (idx == 3) return;
    switch (idx) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed('/quiz');
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed('/material');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildStatusSection(),
                    _buildStatistics(),
                    _buildTabs(),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentIndex = index),
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    ProfileBadgeTab(),
                    ProfileDetailsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: _onNavTap,
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
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF0D47A1),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF4285F4),
                      Color(0xFF003D8F),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: _isScrolled ? 25 : 45,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: _isScrolled ? 22 : 42,
                        child: Icon(
                          Icons.person,
                          size: _isScrolled ? 20 : 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: _isScrolled ? 16 : 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: const Text(
                        '@user',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        title: _isScrolled
            ? Row(
                children: [
                  const Spacer(),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: const CircleAvatar(
                      radius: 14,
                      child: Icon(Icons.person, size: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      '@user',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildStatusSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.calculate_outlined, color: Color(0xFF0D47A1), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'studying "Square Root"',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  '23.59 elapsed',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF0D47A1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Active',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('material readed', '64'),
          _buildVerticalDivider(),
          _buildStatItem('quiz completed', '23'),
          _buildVerticalDivider(),
          _buildStatItem('pages on note', '12'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Badge', 'Details']
                .asMap()
                .entries
                .map((e) => _buildTabItem(e.value, e.key))
                .toList(),
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 3,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
              _buildTabIndicator(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabChange(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0D47A1).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF0D47A1) : Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabIndicator() {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: Alignment(
        _currentIndex == 0 ? -1 : 1,
        0,
      ),
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Container(
          height: 3,
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 1.1,
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ProfileBadgeTab extends StatelessWidget {
  const ProfileBadgeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      {"asset": "assets/Badge_05.png", "label": "King of Math", "desc": "Mastered mathematics"},
      {"asset": "assets/Badge_05.png", "label": "Science Star", "desc": "Top in science"},
      {"asset": "assets/Badge_04.png", "label": "Bookworm", "desc": "Read 20+ materials"},
      {"asset": "assets/Badge_01.png", "label": "Quiz Champion", "desc": "Completed all quizzes"},
      {"asset": "assets/Badge_04.png", "label": "Note Taker", "desc": "10 pages of notes"},
      {"asset": "assets/Badge_05.png", "label": "Active Learner", "desc": "7 days streak"},
    ];

    // Gunakan SingleChildScrollView+Wrap agar tidak membuat scrollbar baru
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 12,
        spacing: 12,
        children: badges.map((badge) {
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 20 * 2 - 12 * 2) / 3,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      badge["asset"]!,
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    badge["label"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xFF2C3E50),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    badge["desc"]!,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ProfileDetailsTab extends StatelessWidget {
  const ProfileDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'icon': Icons.edit_note,
        'title': 'wrote a note about "Climate Zones"',
        'time': '12.23, 10 December 2024',
        'showProgress': false,
      },
      {
        'icon': Icons.quiz_outlined,
        'title': 'completed "Climate Zones" quiz',
        'time': '11.50, 10 December 2024',
        'showProgress': true,
      },
      {
        'icon': Icons.quiz_outlined,
        'title': 'completed "Periodic Table" quiz',
        'time': '15.03, 6 December 2024',
        'showProgress': true,
      },
      {
        'icon': Icons.edit_note,
        'title': 'wrote a note about "Periodic Table"',
        'time': '14.23, 9 December 2024',
        'showProgress': false,
      },
      {
        'icon': Icons.quiz_outlined,
        'title': 'completed "Biology Basics" quiz',
        'time': '09.15, 5 December 2024',
        'showProgress': true,
      },
      {
        'icon': Icons.edit_note,
        'title': 'wrote a note about "Cell Structure"',
        'time': '16.30, 4 December 2024',
        'showProgress': false,
      },
      {
        'icon': Icons.quiz_outlined,
        'title': 'completed "Mathematics" quiz',
        'time': '13.20, 3 December 2024',
        'showProgress': true,
      },
      {
        'icon': Icons.edit_note,
        'title': 'wrote a note about "Algebra"',
        'time': '10.45, 2 December 2024',
        'showProgress': false,
      },
    ];

    // FIX: gunakan SingleChildScrollView + Column, agar tidak overflow dan scrollbar tidak numpuk
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[50],
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'On Going Activities',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                SizedBox(height: 16),
                _OngoingActivityCard(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Past Activities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            activities.length,
            (index) => Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, index == activities.length - 1 ? 0 : 12),
              child: _buildPastActivityCard(
                icon: activities[index]['icon'] as IconData,
                title: activities[index]['title'] as String,
                time: activities[index]['time'] as String,
                showProgressBar: activities[index]['showProgress'] as bool,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildPastActivityCard({
    required IconData icon,
    required String title,
    required String time,
    bool showProgressBar = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF0D47A1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0D47A1),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'time: $time',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                if (showProgressBar) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Accuracy: ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      const Text(
                        '85%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.85,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFF0D47A1),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OngoingActivityCard extends StatelessWidget {
  const _OngoingActivityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF0D47A1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.calculate_outlined,
              color: Color(0xFF0D47A1),
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'studying "Square Root"',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '23.59 elapsed',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}