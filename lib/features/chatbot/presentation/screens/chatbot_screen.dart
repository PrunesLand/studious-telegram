import 'package:flutter/material.dart';
import 'package:university_chatbot/core/index.dart';
import 'package:university_chatbot/features/dashboard/presentation/index.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  SocketIO io = SocketIO();

  @override
  void initState() {
    super.initState();
    io.connectToSocket();
    io.testConnectionHealth();
  }

  @override
  void dispose() {
    io.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable default back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            io.disconnect();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              ModalRoute.withName('/home'),
            );
          },
        ),
        title: Text('Chatbot function'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: Text('Chatbot screen not yet developed.'))],
      ),
    );
  }
}
