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
                  minHeight: MediaQuery.of(context).size.height * 0.65, // Boleh diatur sesuai kebutuhan
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 36), // Tambah padding bawah
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

                      // Divider dengan teks
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

                      // Tombol sosial
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
                            onTap: () {},
                          ),
                          const SizedBox(width: 18),
                          _SocialButton(
                            icon: Icon(Icons.apple, color: Colors.black, size: 26),
                            onTap: () {},
                          ),
                          const SizedBox(width: 18),
                          _SocialButton(
                            icon: Icon(Icons.facebook, color: Color(0xFF1877F3), size: 26),
                            onTap: () {},
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
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: icon,
        ),
      ),
    );
  }
}