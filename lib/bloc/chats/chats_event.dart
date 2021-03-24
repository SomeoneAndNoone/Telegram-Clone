import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ChatEvents extends Equatable {
  const ChatEvents();

  @override
  List<Object> get props => [];
}

class ChatEventsGetChatsEvent extends ChatEvents {
  const ChatEventsGetChatsEvent({@required this.userId});

  final String userId;
}
