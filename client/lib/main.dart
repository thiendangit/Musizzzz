import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/app_theme.dart';
import 'package:client/features/auth/viewModels/auth_view_model.dart';
import 'package:client/features/auth/views/pages/login_page.dart';
import 'package:client/features/auth/views/pages/signup_page.dart';
import 'package:client/features/auth/views/pages/forgot_password_page.dart';
import 'package:client/features/home/views/home_page.dart';
import 'package:client/features/home/views/upload_song.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    // Initialize auth data after the widget is built and providers are available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAuth();
    });
  }

  Future<void> _initializeAuth() async {
    try {
      await ref.read(authViewModelProvider.notifier).initSharedPreferences();

      // Load saved auth data from local storage
      final authViewModel = ref.read(authViewModelProvider.notifier);
      await authViewModel.loadSavedAuth();

      await ref.read(authViewModelProvider.notifier).getData();
    } catch (e) {
      // Handle initialization error silently
    } finally {
      setState(() {
        _isInitializing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the current user notifier provider
    final currentUser = ref.watch(currentUserNotifierProvider);

    // Show loading indicator while initializing
    if (_isInitializing) {
      return MaterialApp(
        title: 'Music App',
        darkTheme: AppTheme.theme,
        themeMode: ThemeMode.light,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Pallete.backgroundColor,
        ),
        home: const Scaffold(
          backgroundColor: Pallete.backgroundColor,
          body: Center(
            child: CircularProgressIndicator(
              color: Pallete.gradient2,
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Music App',
      darkTheme: AppTheme.theme,
      themeMode: ThemeMode.light,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: _border(Pallete.borderColor),
          focusedBorder: _border(Pallete.gradient2),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
      home: currentUser == null
          ? const LoginPageWrapper()
          : const UploadSongPage(),
      routes: {
        '/signup': (context) => const SignupPageWrapper(),
        '/forgot-password': (context) => const ForgotPasswordPageWrapper(),
        '/signin': (context) => const LoginPageWrapper(),
      },
    );
  }

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 3),
      );
}

class SignupPageWrapper extends ConsumerWidget {
  const SignupPageWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SignupPage();
  }
}

class ForgotPasswordPageWrapper extends ConsumerWidget {
  const ForgotPasswordPageWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ForgotPasswordPage();
  }
}

class LoginPageWrapper extends ConsumerWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LoginPage();
  }
}
