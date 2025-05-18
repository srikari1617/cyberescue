import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Main entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login with OTP',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RoleSelectionScreen(),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Role')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Login as Client'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(role: 'Client'),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Login as Lawyer'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(role: 'Lawyer'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final String role;

  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  final copEnrolmentController = TextEditingController();

  String errorMessage = '';
  String generatedOtp = '';
  bool otpSent = false;
  bool otpVerified = false;

  String generateOtp() {
    final random = Random();
    return (100000 + random.nextInt(899999)).toString();
  }

  Future<void> sendOtp() async {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      setState(() {
        errorMessage = 'Enter a valid email';
      });
      return;
    }

    generatedOtp = generateOtp();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('OTP Sent'),
        content: Text(
            'Your OTP is: $generatedOtp\n(Simulated, send this via email in real app)'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                otpSent = true;
                errorMessage = '';
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void verifyOtp() {
    if (otpController.text.trim() == generatedOtp) {
      setState(() {
        otpVerified = true;
        errorMessage = '';
      });
    } else {
      setState(() {
        errorMessage = 'Invalid OTP. Please try again.';
      });
    }
  }

  Future<void> loginUser() async {
    if (widget.role == 'Lawyer' && copEnrolmentController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'Please enter your COP Enrolment Number';
      });
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged in as ${widget.role}')),
      );
      // TODO: Navigate to your dashboard or home screen
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "Login failed";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.role} Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: otpSent
            ? otpVerified
                ? Column(
                    children: [
                      if (widget.role == 'Lawyer') ...[
                        TextField(
                          controller: copEnrolmentController,
                          decoration: const InputDecoration(
                              labelText: "COP Enrolment Number"),
                        ),
                        const SizedBox(height: 10),
                      ],
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: loginUser,
                        child: const Text('Login'),
                      ),
                      if (errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(errorMessage,
                              style: const TextStyle(color: Colors.red)),
                        ),
                    ],
                  )
                : Column(
                    children: [
                      Text('Enter OTP sent to ${emailController.text}'),
                      TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "OTP"),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: verifyOtp,
                        child: const Text('Verify OTP'),
                      ),
                      TextButton(
                        onPressed: sendOtp,
                        child: const Text('Resend OTP'),
                      ),
                      if (errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(errorMessage,
                              style: const TextStyle(color: Colors.red)),
                        ),
                    ],
                  )
            : Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: sendOtp,
                    child: const Text('Send OTP'),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(errorMessage,
                          style: const TextStyle(color: Colors.red)),
                    ),
                ],
              ),
      ),
    );
  }
}
