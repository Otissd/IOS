import 'package:flutter/material.dart';
import 'package:musicapp/providers/album_provider.dart';
import 'package:musicapp/providers/user_provider.dart';

import 'package:musicapp/pages/home.dart';
import 'package:provider/provider.dart';

import 'signup_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AlbumProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Container
              Container(
                width: 800, // Adjust logo width
                height: 200, // Adjust logo height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/musicix3.png"), // Ensure the path is correct
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Login Form Container
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Username Field
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Tên Đăng Nhập",
                        labelStyle: TextStyle(
                          color: Colors.black, // Change label text color
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Change color of the enabled border
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .black, // Change color of the border when focused
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password Field
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: "Mật Khẩu",
                        labelStyle: const TextStyle(
                          color: Colors.black, // Change label text color
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Change color of the enabled border
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .black, // Change color of the border when focused
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Sign-Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Bạn chưa có tài khoản?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: const Text(
                            "Tạo tài khoản mới",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Login Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize:
                            const Size.fromHeight(50), // Full-width button
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Đăng Nhập",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Social Login Section
              const Text("Đăng nhập với:"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Google login logic
                    },
                    icon: const Icon(Icons.g_mobiledata,
                        size: 32, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      // Facebook login logic
                    },
                    icon: const Icon(
                      Icons.facebook,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Apple login logic
                    },
                    icon:
                        const Icon(Icons.apple, size: 32, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Login function
  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Call the login method from UserProvider
    bool loginSuccess = await userProvider.login(
      _usernameController.text,
      _passwordController.text,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              loginSuccess ? "Đăng nhập thành công" : "Đăng nhập thất bại"),
          content: Text(loginSuccess
              ? "Chào mừng bạn đã đăng nhập!"
              : "Tên đăng nhập hoặc mật khẩu không chính xác."),
        );
      },
    );

    setState(() {
      _isLoading = false;
    });

    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      Navigator.of(context).pop(); // Close the dialog
    }

    if (loginSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomePage()), // Replace current screen with Profile page
      );
      // Handle successful login (e.g., redirect to another screen)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Chuyển hướng sau khi đăng nhập thành công")),
      );
    }
  }
}
