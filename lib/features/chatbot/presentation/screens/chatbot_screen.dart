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
  final _formKey = GlobalKey<FormState>(); // Form key
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
    controller.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (_formKey.currentState?.validate() ?? false) {
      final text = controller.text.trim();
      if (text.isNotEmpty) {
        // Dispatch the event with the message text
        context.read<ChatbotBloc>().add(ChatbotEvent.sendMessage(text));
        controller.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatbotBloc, ChatbotState>(
      listener: (context, state) {
        if (state.isClicked) print('${state.messages[0]?.text} PRUNE');
      },
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(title: Text('Simple Chat')),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: state.messages.length,
                    itemBuilder:
                        (_, i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(state.messages[i]?.text ?? ''),
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            autofocus: true,
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a message';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => sendMessage(),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: sendMessage,
                          child: Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
