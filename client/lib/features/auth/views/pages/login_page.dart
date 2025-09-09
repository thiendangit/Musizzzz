import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/viewModels/auth_view_model.dart';
import 'package:client/features/auth/views/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/views/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _lastShownError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    if (formKey.currentState!.validate()) {
      // Clear any previous error state when attempting new login
      _lastShownError = null;

      // Use AuthViewModel instead of calling repository directly
      await ref.read(authViewModelProvider.notifier).signIn(
            email: emailController.text,
            password: passwordController.text,
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the auth state to show loading and handle success/error
    final authState = ref.watch(authViewModelProvider);

    // Show loading indicator when signing in
    if (authState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show error message if there's an error (only once per unique error)
    if (authState.errorMessage != null &&
        authState.errorMessage != _lastShownError) {
      _lastShownError = authState.errorMessage;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authState.errorMessage!),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
          // Clear the error after showing
          ref.read(authViewModelProvider.notifier).clearError();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    'Sign In.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  CustomField(
                    hintText: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomField(
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    onPressed: loginUser,
                    text: "Sign In",
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Pallete.whiteColor),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                            color: Pallete.gradient2,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context,
                                  '/signup'); // Navigate to signup page
                            },
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context,
                          '/forgot-password'); // Navigate to forgot password page
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Pallete.gradient2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
