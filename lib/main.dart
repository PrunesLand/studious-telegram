import 'package:flutter/material.dart';
import 'package:university_chatbot/features/chatbot/presentation/index.dart';
import 'package:university_chatbot/features/onboarding/index.dart';
import 'features/dashboard/presentation/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Droid Learner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LandingPage(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/home': (context) => HomeScreen(),
        '/chatbot': (context) => ChatbotScreen(),
      },
    );
  }
}
