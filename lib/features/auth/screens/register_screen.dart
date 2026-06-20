import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';
import '../../catalog/screens/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  // ambil input user
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                          "Register",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue[700],
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Buat akun baru",
                          style: TextStyle(color: Colors.lightBlue),
                        ),

                        SizedBox(height: 30),
                        // input nama
                        TextField(
                          controller: nameController,
                          style: TextStyle(color: Colors.lightBlue),
                          decoration: InputDecoration(
                            hintText: "Nama",
                            hintStyle: TextStyle(
                              color: Colors.lightBlue.shade200,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        // input email
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.lightBlue),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Colors.lightBlue.shade200,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        // input password
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(color: Colors.lightBlue),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.lightBlue.shade200,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        // konfirmasi password
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          style: TextStyle(color: Colors.lightBlue),
                          decoration: InputDecoration(
                            hintText: "Konfirmasi Password",
                            hintStyle: TextStyle(
                              color: Colors.lightBlue.shade200,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),
                        // tombol
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              String name = nameController.text.trim();
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();
                              String confirmPassword = confirmPasswordController
                                  .text
                                  .trim();
                              // cek kalo kosong
                              if (name.isEmpty ||
                                  email.isEmpty ||
                                  password.isEmpty ||
                                  confirmPassword.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Semua field harus diisi"),
                                  ),
                                );
                                return;
                              }
                              // validasi konfirmasi password apakah sama
                              if (password != confirmPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Password tidak sama"),
                                  ),
                                );
                                return;
                              }
                              // regis ke firebase
                              try {
                                await auth.signUp(email, password);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                );
                                // notifikasi sukses
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Register berhasil")),
                                );
                                // pindah ke login
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Register gagal")),
                                );
                              }
                            },
                            child: Text(
                              "Daftar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        // pindah ke login jika udah ada akun
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sudah punya akun? "),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  "Login",
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
