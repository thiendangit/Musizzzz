import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MySimpleApp()));
}

class MySimpleApp extends ConsumerStatefulWidget {
  const MySimpleApp({super.key});

  @override
  ConsumerState<MySimpleApp> createState() => _MySimpleAppState();
}

class _MySimpleAppState extends ConsumerState<MySimpleApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Test App',
      home: const Scaffold(
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
