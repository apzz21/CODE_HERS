import 'package:flutter/material.dart';
import 'package:pet_haven/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _login() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Backend not connected. Login functionality unavailable."),
      ),
    );
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: const Color(0xFFFDEEE9), // Light nude pinkish background
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: width,
            height: isKeyboardVisible ? 0 : height * 0.45,
            color: const Color(0xFFF9D9D3), // Slightly darker nude pinkish for the logo background
            child: Center(
              child: Image.asset(
                'lib/assets/logo.png', // Replace with the path to your image
                fit: BoxFit.contain, // Adjust the image to fit the available space
                width: width * 1.9, // Adjust image width based on screen width
                height: isKeyboardVisible ? 0 : height * 1.95, // Dynamically change image height based on keyboard visibility
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: isKeyboardVisible ? 60 : height * 0.02),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: height * 0.035,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 87, 29, 29), // Matches the logo text
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email Address',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: height * 0.02),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: const Color.fromARGB(255, 85, 32, 32), // Matches theme
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Color.fromARGB(255, 68, 28, 28)), // Matches theme
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 114, 58, 58), // Button matches theme
                      minimumSize: Size(width * 0.85, height * 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member?"),
                      TextButton(
                        onPressed: _register,
                        child: const Text(
                          'Register now',
                          style: TextStyle(color: Color.fromARGB(255, 36, 14, 14)), // Matches theme
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 252, 185, 185), // Matches theme
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: width * 0.85,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 15.0,
              ),
              suffixIcon: suffixIcon,
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }
}
