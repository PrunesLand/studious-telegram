part of 'chatbot_bloc.dart';

@freezed
abstract class ChatbotState with _$ChatbotState {
  const factory ChatbotState({
    @Default('') String message,
    @Default(false) bool isClicked,
    @Default([]) List<MessageModel?> messages,
  }) = _ChatbotState;

  factory ChatbotState.initialize() => const ChatbotState();
}
