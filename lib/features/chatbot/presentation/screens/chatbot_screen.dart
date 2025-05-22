import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatbot/core/index.dart';
import 'package:university_chatbot/features/chatbot/presentation/bloc/chatbot_bloc.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<String> messages = [];
  final TextEditingController controller = TextEditingController();
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

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(text);
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatbotBloc, ChatbotState>(
      listener: (context, state) {
        if (state.isClicked) print('${state.message} PRUNE');
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Simple Chat')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder:
                    (_, i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(messages[i]),
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => sendMessage(),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed:
                        () => context.read<ChatbotBloc>().add(
                          ChatbotEvent.sendMessage(),
                        ),
                    child: Icon(Icons.send),
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
