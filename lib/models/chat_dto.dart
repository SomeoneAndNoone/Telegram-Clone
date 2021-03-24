import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/common/constants/firebase_keys.dart';

class ChatDto extends Equatable {
  const ChatDto({
    @required this.chatId,
    @required this.createdAt,
    @required this.userIds,
    @required this.userNames,
    @required this.userPictures,
    @required this.user1UnreadMessageCount,
    @required this.user2UnreadMessageCount,
    @required this.lastMessageDate,
    @required this.lastMessageSent,
  });

  final String chatId;
  final int createdAt;
  final List<String> userIds;
  final List<String> userNames;
  final List<String> userPictures;
  final int user1UnreadMessageCount;
  final int user2UnreadMessageCount;
  final int lastMessageDate;
  final String lastMessageSent;

  String getFriendPicture(String activeUserId) {
    if (activeUserId == userIds[0]) {
      return userPictures[1];
    }
    return userPictures[0];
  }

  String getFriendName(String activeUserId) {
    if (activeUserId == userIds[0]) {
      return userNames[1];
    }
    return userNames[0];
  }

  String getFriendId(String activeUserId) {
    if (activeUserId == userIds[0]) {
      return userIds[1];
    }
    return userIds[0];
  }

  int activeUserUnreadMessageCount(String activeUserId) {
    if (activeUserId == userIds[0]) {
      return user1UnreadMessageCount;
    }
    return user2UnreadMessageCount;
  }

  static ChatDto toChatDtoFromSnapshot(QueryDocumentSnapshot snapshot) {
    return ChatDto(
      chatId: snapshot[FirebaseChatsFields.uid],
      createdAt: snapshot[FirebaseChatsFields.createdAt],
      userIds: snapshot[FirebaseChatsFields.userIds],
      userNames: snapshot[FirebaseChatsFields.userNames],
      userPictures: snapshot[FirebaseChatsFields.userPictures],
      user1UnreadMessageCount: snapshot[FirebaseChatsFields.user1UnreadMessageCount],
      user2UnreadMessageCount: snapshot[FirebaseChatsFields.user2UnreadMessageCount],
      lastMessageDate: snapshot[FirebaseChatsFields.lastMessageDate],
      lastMessageSent: snapshot[FirebaseChatsFields.lastMessageSent],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FirebaseChatsFields.uid: chatId,
      FirebaseChatsFields.createdAt: createdAt,
      FirebaseChatsFields.userIds: userIds,
      FirebaseChatsFields.userNames: userNames,
      FirebaseChatsFields.userPictures: userPictures,
      FirebaseChatsFields.user1UnreadMessageCount: user1UnreadMessageCount,
      FirebaseChatsFields.user2UnreadMessageCount: user2UnreadMessageCount,
      FirebaseChatsFields.lastMessageDate: lastMessageDate,
      FirebaseChatsFields.lastMessageSent: lastMessageSent,
    };
  }

  ChatDto copyWith({
    String chatId,
    int createdAt,
    List<String> userIds,
    List<String> userNames,
    List<String> userPictures,
    int user1UnreadMessageCount,
    int user2UnreadMessageCount,
    int lastMessageDate,
    String lastMessageSent,
  }) {
    return ChatDto(
      chatId: chatId ?? this.chatId,
      createdAt: createdAt ?? this.createdAt,
      userIds: userIds ?? this.userIds,
      userNames: userNames ?? this.userNames,
      userPictures: userPictures ?? this.userPictures,
      user1UnreadMessageCount: user1UnreadMessageCount ?? this.user1UnreadMessageCount,
      user2UnreadMessageCount: user2UnreadMessageCount ?? this.user2UnreadMessageCount,
      lastMessageSent: lastMessageSent ?? this.lastMessageSent,
      lastMessageDate: lastMessageDate ?? this.lastMessageDate,
    );
  }

  @override
  List<Object> get props => [chatId];
}
