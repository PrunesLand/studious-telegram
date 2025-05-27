part of 'chatbot_bloc.dart';

@freezed
abstract class ChatbotEvent with _$ChatbotEvent {
  const factory ChatbotEvent.sendMessage(String message) = _SendMessage;
}
