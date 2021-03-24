import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/models/message_dto.dart';
import 'package:telegram_clone/models/user_dto.dart';

abstract class MessageEvents extends Equatable {
  const MessageEvents();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends MessageEvents {
  const GetMessagesEvent();

  @override
  List<Object> get props => [];
}

class MessagesReceivedEvent extends MessageEvents {
  const MessagesReceivedEvent({@required this.messages});

  final List<MessageDto> messages;

  @override
  List<Object> get props => [messages];
}

class SendMessageEvent extends MessageEvents {
  const SendMessageEvent({
    @required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}

class EditMessageEvent extends MessageEvents {
  const EditMessageEvent({@required this.oldMessage, @required this.newMessage});

  final newMessage;
  final MessageDto oldMessage;

  @override
  List<Object> get props => [newMessage, oldMessage];
}

class DeleteMessageEvent extends MessageEvents {
  const DeleteMessageEvent({
    @required this.messsageDto,
    @required this.user1,
    @required this.user2,
  });

  final MessageDto messsageDto;
  final UserDto user1;
  final UserDto user2;

  @override
  List<Object> get props => [messsageDto, user1, user2];
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
///
