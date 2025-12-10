import 'package:flutter/material.dart';
import 'package:sips/screens/onboarding/welcome_page.dart';
import 'package:sips/service/app_provider.dart';
import 'package:sips/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:sips/screens/onboarding/flash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
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
      title: 'Flutter Demo',
      theme: ThemeClass.lightTheme,
      home: const FlashScreen(),
    );
  }
}
