import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:client/main.dart';

void main() {
  testWidgets('MyApp instantiation test', (WidgetTester tester) async {
    // Test if MyApp can be instantiated without errors
    expect(() => const MyApp(), returnsNormally);

    // Test if MyApp can be wrapped in ProviderScope
    expect(() => const ProviderScope(child: MyApp()), returnsNormally);
  });
}
