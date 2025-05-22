part of 'chatbot_bloc.dart';

@freezed
class ChatbotEvent with _$ChatbotEvent {
  const factory ChatbotEvent.sendMessage() = _SendMessage;
}
