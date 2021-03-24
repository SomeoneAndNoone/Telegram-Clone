import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/common/constants/firebase_keys.dart';

class MessageStatus {
  static String notSent = 'notSent';
  static String sent = 'sent';
  static String read = 'read';
}

class MessageDto extends Equatable {
  MessageDto({
    @required this.messageId,
    @required this.chatId,
    @required this.message,
    @required this.sentAt,
    @required this.status, // notSent, sent, read
    @required this.ownerId,
    @required this.ownerName,
    @required this.ownerPicture,
    @required this.receiverId,
    @required this.isDeleted,
    @required this.participantIds,
  });

  final String messageId;
  final String chatId;
  final String message;
  final int sentAt;
  final List<String> participantIds;
  final String status;
  final String ownerName;
  final String ownerPicture;
  final String ownerId;
  final String receiverId;
  final bool isDeleted;

  static MessageDto toMessageDtoFromSnapshot(QueryDocumentSnapshot snapshot) {
    return MessageDto(
      messageId: snapshot[FirebaseMessageFields.uid],
      chatId: snapshot[FirebaseMessageFields.chatId],
      message: snapshot[FirebaseMessageFields.message],
      sentAt: snapshot[FirebaseMessageFields.sentAt],
      status: snapshot[FirebaseMessageFields.status],
      ownerId: snapshot[FirebaseMessageFields.ownerId],
      ownerName: snapshot[FirebaseMessageFields.ownerName],
      ownerPicture: snapshot[FirebaseMessageFields.ownerPicture],
      receiverId: snapshot[FirebaseMessageFields.receiverId],
      isDeleted: snapshot[FirebaseMessageFields.isDeleted],
      participantIds: snapshot[FirebaseMessageFields.participantIds],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FirebaseMessageFields.uid: messageId,
      FirebaseMessageFields.chatId: chatId,
      FirebaseMessageFields.message: message,
      FirebaseMessageFields.sentAt: sentAt,
      FirebaseMessageFields.status: status,
      FirebaseMessageFields.ownerId: ownerId,
      FirebaseMessageFields.ownerName: ownerName,
      FirebaseMessageFields.ownerPicture: ownerPicture,
      FirebaseMessageFields.receiverId: receiverId,
      FirebaseMessageFields.isDeleted: isDeleted,
      FirebaseMessageFields.participantIds: participantIds,
    };
  }

  MessageDto copyWith({
    String messageId,
    String chatId,
    String message,
    int sentAt,
    List<String> participantIds,
    String status,
    String ownerName,
    String ownerPicture,
    String ownerId,
    String receiverId,
    bool isDeleted,
  }) {
    return MessageDto(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
      status: status ?? this.status,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      ownerPicture: ownerPicture ?? this.ownerPicture,
      receiverId: receiverId ?? this.receiverId,
      isDeleted: isDeleted ?? this.isDeleted,
      participantIds: participantIds ?? this.participantIds,
    );
  }

  @override
  List<Object> get props => [messageId];
}
