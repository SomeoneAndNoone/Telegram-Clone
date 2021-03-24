import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_clone/bloc/message_bloc/message_event.dart';
import 'package:telegram_clone/bloc/message_bloc/message_state.dart';
import 'package:telegram_clone/common/exceptions/informative_exception.dart';
import 'package:telegram_clone/models/chat_dto.dart';
import 'package:telegram_clone/models/message_dto.dart';
import 'package:telegram_clone/models/user_dto.dart';
import 'package:telegram_clone/repository/messages/firebase_messages.dart';
import 'package:uuid/uuid.dart';

class MessageBloc extends Bloc<MessageEvents, MessageStates> {
  MessageBloc(this._firebaseMessages, this.from, this.to) : super(MessageUninitializedState()) {
    setChatMemory(from, to);
    add(GetMessagesEvent());
  }

  FirebaseMessages _firebaseMessages;
  UserDto from;
  UserDto to;

  StreamSubscription<List<MessageDto>> _messageStream;

  List<MessageDto> messagesInMemory = [];
  ChatDto _chatInMemory;

  Uuid _uuid = Uuid();

  @override
  Stream<MessageStates> mapEventToState(MessageEvents event) async* {
    debugPrint('New Event Request: $event');

    if (event is GetMessagesEvent) {
      try {
        yield MessagesLoadingState();

        if (_messageStream == null) {
          _messageStream = _firebaseMessages.getMessagesStream(from, to).listen((messages) {
            messagesInMemory = messages;
            add(MessagesReceivedEvent(messages: messages));
          });
        }
      } on InformativeException catch (e) {
        yield GetMessagesErrorState(e.message);
      }
    }

    if (event is SendMessageEvent) {
      setChatMemory(from, to);

      MessageDto newMessage = MessageDto(
        messageId: _uuid.v1(),
        chatId: _chatInMemory.chatId,
        message: event.message,
        sentAt: DateTime.now().millisecondsSinceEpoch,
        status: MessageStatus.notSent,
        ownerId: from.userId,
        ownerName: from.userName,
        ownerPicture: from.picture,
        receiverId: to.userId,
        isDeleted: false,
        participantIds: [from.userId, from.userId],
      );
      messagesInMemory.insert(0, newMessage);

      yield MessagesReceivedState(messages: messagesInMemory);

      MessageDto sentMessage = await _firebaseMessages.sendMessage(from, to, newMessage);

      yield MessageSentState(message: sentMessage);
    }

    if (event is MessagesReceivedEvent) {
      yield MessagesReceivedState(messages: null);
    }
  }

  void setChatMemory(UserDto user1, UserDto user2) async {
    if (_chatInMemory == null) {
      _chatInMemory = ChatDto.toChatDtoFromSnapshot(
          await _firebaseMessages.createNewOrGetExistingChatSnapshot(user1, user2));
    }
  }

  @override
  Future<void> close() {
    if (_messageStream != null) {
      _messageStream.cancel();
    }
    return super.close();
  }
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
