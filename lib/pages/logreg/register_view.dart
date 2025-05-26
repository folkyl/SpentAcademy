import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _obscure = true;

  // Method untuk handle social login
  void _handleSocialLogin(String provider) {
    _showSocialLoginDialog(provider);
  }

  void _showSocialLoginDialog(String provider) {
    String title = '';
    String content = '';
    Color iconColor = Colors.blueAccent;
    IconData iconData = Icons.login;

    switch (provider) {
      case 'Google':
        title = 'Sign up with Google';
        content = 'You\'ll be redirected to Google to sign in with your Google account. Your Google profile information will be used to create your SpentAcademy account.';
        iconColor = Colors.red;
        iconData = Icons.g_mobiledata;
        break;
      case 'Apple':
        title = 'Sign up with Apple';
        content = 'You\'ll be redirected to Apple to sign in with your Apple ID. Your Apple ID information will be used to create your SpentAcademy account securely.';
        iconColor = Colors.black;
        iconData = Icons.apple;
        break;
      case 'Facebook':
        title = 'Sign up with Facebook';
        content = 'You\'ll be redirected to Facebook to sign in with your Facebook account. Your Facebook profile information will be used to create your SpentAcademy account.';
        iconColor = const Color(0xFF1877F3);
        iconData = Icons.facebook;
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                iconData,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.blue.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Your data is protected and secure with us.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: iconColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _processSocialLogin(provider);
            },
            child: Text('Continue with $provider'),
          ),
        ],
      ),
    );
  }

  void _processSocialLogin(String provider) {
    // Simulasi loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  provider == 'Google' ? Colors.red :
                  provider == 'Apple' ? Colors.black :
                  const Color(0xFF1877F3),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Connecting to $provider...',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please wait while we set up your account.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    // Simulasi delay untuk proses login
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Tutup loading dialog
      
      // TODO: Di sini Anda bisa menambahkan logic untuk:
      // 1. Panggil API social login
      // 2. Simpan token/user data
      // 3. Navigate ke halaman selanjutnya
      
      // Untuk sekarang, tampilkan hasil sukses
      _showSuccessDialog(provider);
    });
  }

  void _showSuccessDialog(String provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.green,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Account Created Successfully!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome to SpentAcademy! Your account has been created using $provider.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C73DD),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Navigate ke dashboard atau halaman utama
                // Get.offAllNamed(AppRoutes.dashboard);
              },
              child: const Text(
                'Get Started',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background biru
          Container(
            color: const Color(0xFF2C73DD),
          ),
          // Card putih dengan border radius atas
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.65,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sign up to start your learning journey!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 8),
                              child: Icon(Icons.email_outlined, color: Colors.blueAccent),
                            ),
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Username
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 8),
                              child: Icon(Icons.person_outline, color: Colors.blueAccent),
                            ),
                            hintText: 'Username',
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: TextFormField(
                          obscureText: _obscure,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 8),
                              child: Icon(Icons.lock_outline, color: Colors.blueAccent),
                            ),
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure ? Icons.visibility_off : Icons.visibility,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Teks sudah punya akun
                      Text(
                        'Already have an account? Log in now!',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tombol Login dan Sign Up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Tombol Login (Outlined)
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blueAccent,
                              side: const BorderSide(color: Colors.blueAccent, width: 2),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => Get.toNamed(AppRoutes.login),
                            child: const Text('Login'),
                          ),
                          const SizedBox(width: 16),
                          // Tombol Sign Up (Gradasi)
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF0D47A1), Color(0xFF4285F4)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  // TODO: Tambahkan aksi sign up di sini
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Divider dengan teks (Static)
                      Row(
                        children: [
                          const Expanded(child: Divider(color: Color(0xFFCED6E0))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Or sign up with',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: Color(0xFFCED6E0))),
                        ],
                      ),
                      const SizedBox(height: 22),

                      // Tombol sosial (Clickable)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialButton(
                            icon: Image.asset(
                              'assets/google.png',
                              width: 28,
                              height: 28,
                              fit: BoxFit.contain,
                            ),
                            onTap: () => _handleSocialLogin('Google'),
                          ),
                          const SizedBox(width: 18),
                          _SocialButton(
                            icon: Icon(Icons.apple, color: Colors.black, size: 26),
                            onTap: () => _handleSocialLogin('Apple'),
                          ),
                          const SizedBox(width: 18),
                          _SocialButton(
                            icon: Icon(Icons.facebook, color: Color(0xFF1877F3), size: 26),
                            onTap: () => _handleSocialLogin('Facebook'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 38),

                      // Footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.computer, color: Colors.blueAccent, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'We safeguard your personal data.',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Tombol Info di pojok kanan atas
          Positioned(
            top: 30,
            right: 30,
            child: IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Apa Itu SpentAcademy?'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'SpentAcademy adalah aplikasi belajar online yang seru dan mudah digunakan untuk siswa siswi SMPN 6 Malang. '
                            'Di sini, kamu bisa belajar berbagai mata pelajaran seperti Matematika, IPA, Bahasa Indonesia, '
                            'Bahasa Inggris, dan banyak lagi, langsung dari HP kamu.\n\n'
                            'Dengan latihan soal interaktif dan rangkuman materi yang jelas, '
                            'belajar jadi lebih menyenangkan dan tidak membosankan. SpentAcademy juga punya fitur kuis dan '
                            'penghargaan yang bisa bikin kamu semangat belajar dan bersaing dengan teman-temanmu.\n\n'
                            'Kenapa Pilih SpentAcademy?',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 12),
                          Text('• Materi sesuai kurikulum SMP'),
                          Text('• Belajar dari mana saja dan kapan saja'),
                          Text('• Latihan soal yang seru dan terbarui'),
                          Text('• Dapat lencana dan sertifikat sebagai penghargaan'),
                          SizedBox(height: 12),
                          Text(
                            'SpentAcademy siap bantu kamu jadi lebih pintar dan siap menghadapi ujian. '
                            'Yuk, gabung sekarang dan jadikan belajar sebagai kegiatan yang kamu sukai!',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Tutup',
                          style: TextStyle(color: Color(0xFF2C73DD)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk tombol sosial
class _SocialButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final Color borderColor;

  const _SocialButton({
    required this.icon,
    required this.onTap,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 2, // Tambah sedikit shadow untuk efek visual
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1), // Tambah border tipis
            borderRadius: BorderRadius.circular(12),
          ),
          child: icon,
        ),
      ),
    );
  }
}