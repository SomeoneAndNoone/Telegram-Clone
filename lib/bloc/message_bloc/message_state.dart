import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/models/message_dto.dart';

abstract class MessageStates extends Equatable {
  const MessageStates();

  @override
  List<Object> get props => [];
}

class MessageUninitializedState extends MessageStates {}

class MessagesLoadingState extends MessageStates {}

class MessagesReceivedState extends MessageStates {
  const MessagesReceivedState({@required this.messages});

  final List<MessageDto> messages;

  @override
  List<Object> get props => [messages];
}

class GetMessagesErrorState extends MessageStates {
  const GetMessagesErrorState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class MessageSendingError extends MessageStates {
  const MessageSendingError(this.message);

  final MessageDto message;

  @override
  List<Object> get props => [message];
}

class MessageStatusUpdatedState extends MessageStates {
  const MessageStatusUpdatedState({this.message});

  final MessageDto message;

  @override
  List<Object> get props => [message];
}

class MessageSentState extends MessageStates {
  const MessageSentState({@required this.message});

  final MessageDto message;

  @override
  List<Object> get props => [message];
}

class MessageDeletedState extends MessageStates {
  const MessageDeletedState({@required this.message});

  final MessageDto message;

  @override
  List<Object> get props => [message];
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
