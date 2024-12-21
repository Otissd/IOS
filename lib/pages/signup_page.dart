import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignUpPage(),
  ));
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextFormField createTextBox(
  TextEditingController txtController,
  String label,
  FormFieldValidator<String> validator, {
  bool obscureText = false,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: txtController,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey, // Enabled border color
          width: 1.5,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2.0),
      ),
      suffixIcon: suffixIcon,
    ),
    validator: validator,
  );
}

class _SignUpPageState extends State<SignUpPage> {
  bool _passwordVisible = false;
  bool _isLoading = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Container
              Container(
                width: 700, // Adjust logo width
                height: 200, // Adjust logo height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/musicix2.png"), // Ensure the path is correct
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
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username Field
                      createTextBox(_usernameController, "Enter username",
                          validateUsername),
                      const SizedBox(height: 20),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Select Date",
                          border: OutlineInputBorder(),
                        ),
                        controller: _dobController,
                        readOnly: true, // Prevent editing directly
                        onTap: () => _selectDate(context),
                      ),
                      const SizedBox(height: 20),
                      // Password Field
                      createTextBox(
                        _passwordController,
                        "Enter password",
                        validatePassword,
                        obscureText: !_passwordVisible,
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
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      createTextBox(
                        _repasswordController,
                        "Re-enter password",
                        (value) =>
                            validateRePassword(value, _passwordController.text),
                        obscureText: !_passwordVisible,
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
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      createTextBox(_emailController, "Email", validateEmail),

                      const SizedBox(height: 20),
                      createTextBox(
                          _phoneController, "PhoneNumber", validatePhoneNo),
                      const SizedBox(height: 20),

                      // Sign-Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Bạn chưa có tài khoản?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          TextButton(
                            onPressed: () {
                              // Navigate to sign-up page logic
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
                        onPressed: _isLoading ? null : _signup,
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
                    icon: const Icon(Icons.g_mobiledata, size: 32),
                  ),
                  IconButton(
                    onPressed: () {
                      // Facebook login logic
                    },
                    icon: const Icon(Icons.facebook, size: 32),
                  ),
                  IconButton(
                    onPressed: () {
                      // Apple login logic
                    },
                    icon: const Icon(Icons.apple, size: 32),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default date
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime.now(), // Latest date
    );

    if (pickedDate != null) {
      // Format the selected date
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dobController.text = formattedDate;
      });
    }
  }
}

String? validateUsername(String? username) {
  if (username == null || username.isEmpty) {
    return "Enter your name, please:";
  }
  if (username.length <= 5) {
    return "Must have > 5 characters";
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return "Enter your password, please:";
  }
  if (password.length <= 6) {
    return "Must have > 6 characters";
  }
  return null;
}

String? validateRePassword(String? repassword, String? password) {
  if (repassword == null || repassword.isEmpty) {
    return "Enter your repassword, please:";
  }
  if (password == null || password != repassword) {
    return "Passwords do not match.";
  }
  return null;
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return "Enter your email, please:";
  }
  if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
      .hasMatch(email)) {
    return "Email is not valid.";
  }
  return null;
}

String? validatePhoneNo(String? phoneNo) {
  if (phoneNo == null || phoneNo.isEmpty) {
    return "Enter your phone number, please:";
  }
  if (!RegExp(r'^\d+$').hasMatch(phoneNo)) {
    return "Phone number must contain only digits.";
  }
  if (phoneNo.length != 10) {
    return "Phone number must be exactly 10 digits.";
  }
  return null; // Valid phone number
}

void _signup() async {
  
}
