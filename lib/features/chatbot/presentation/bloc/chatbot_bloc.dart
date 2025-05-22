import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatbot_bloc.freezed.dart';
part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  ChatbotBloc() : super(const ChatbotState()) {
    on<_SendMessage>(_onSendMessage);
  }

  Future<void> _onSendMessage(
    _SendMessage event,
    Emitter<ChatbotState> emit,
  ) async {
    print('_onSendMessageClicked');
    emit(state.copyWith(isClicked: true, message: 'PRUNE'));
  }
}
