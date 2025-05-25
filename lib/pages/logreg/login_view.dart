import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spentacademy/routes/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Log in to access your learning journey!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30), // Tambahan jarak

                    // Username TextField
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 16, // Ukuran font lebih kecil
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 8), // Padding ikon lebih kecil
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

                    // Password TextField dengan toggle visibility
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: TextFormField(
                        obscureText: _obscure,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
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
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Teks Sign Up
                    Text(
                      'New to SpentAcademy? Sign Up now to get started!',
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
                          onPressed: () {
                            // Validasi login di sini
                            Get.offAllNamed('/home'); // atau Get.offAllNamed(AppRoutes.home);
                          },
                          child: const Text('Login'),
                        ),
                        const SizedBox(width: 16),
                        // Tombol Sign Up (Gradasi)
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0D47A1), Color(0xFF4285F4)], // Ganti warna sesuai selera
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
                                Get.toNamed(AppRoutes.register);
                                // TODO: Tambahkan aksi sign up di sini
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                child: const Text(
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
                    const SizedBox(height: 50),
                    // Tambahan: Data protection info
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

          // Tombol Info di pojok kanan atas (harus di Stack, bukan di Column)
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