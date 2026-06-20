import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';
import '../../catalog/screens/home_screen.dart';
import '../../auth/widgets/custom_textfield.dart';
import '../../auth/widgets/custom_buttons.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  // ambil input email & password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.lightBlue,
            displayColor: Colors.lightBlue,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        // logo evand coding store
                        Center(
                          child: Image.asset("images/ecs.png", height: 180),
                        ),

                        SizedBox(height: 20),
                        // judul
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue[700],
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Masuk ke akun kamu",
                          style: TextStyle(color: Colors.lightBlue),
                        ),

                        SizedBox(height: 30),
                        // input email
                        CustomTextField(
                          controller: emailController,
                          hint: "Email",
                        ),

                        SizedBox(height: 20),
                        // input password
                        CustomTextField(
                          controller: passwordController,
                          hint: "Password",
                          obscure: true,
                        ),

                        SizedBox(height: 30),
                        // tombol login
                        CustomButton(
                          text: "Login",
                          onPressed: () async {
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();
                            // cek kalo kosong
                            if (email.isEmpty || password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Email & Password wajib diisi"),
                                ),
                              );
                              return;
                            }
                            // validasi email
                            if (!email.contains("@")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Format email tidak valid"),
                                ),
                              );
                              return;
                            }

                            try {
                              // login ke firebase dan dapetin token
                              final token = await auth.signIn(email, password);

                              print("ACCESS TOKEN: $token");

                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("Access Token"),
                                  content: SingleChildScrollView(
                                    child: Text(token),
                                  ),
                                ),
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => HomeScreen()),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString().contains("verifikasi")
                                        ? "Email belum diverifikasi, cek inbox kamu"
                                        : "Email atau password salah",
                                  ),
                                ),
                              );
                            }
                          },
                        ),

                        SizedBox(height: 10),

                        Center(
                          child: TextButton(
                            onPressed: () async {
                              try {
                                await auth.signInWithGoogle();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login Google gagal")),
                                );
                              }
                            },
                            child: Text(
                              "Login with Google",
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // pindah ke register kalo belum ada akun
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Belum punya akun? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Daftar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
