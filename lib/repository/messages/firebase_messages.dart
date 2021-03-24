import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telegram_clone/common/constants/firebase_keys.dart';
import 'package:telegram_clone/common/exceptions/informative_exception.dart';
import 'package:telegram_clone/models/chat_dto.dart';
import 'package:telegram_clone/models/message_dto.dart';
import 'package:telegram_clone/models/user_dto.dart';

class FirebaseMessages {
  Stream<List<MessageDto>> getMessagesStream(UserDto user1, UserDto user2) {
    try {
      return FirebaseFirestore.instance
          .collection(FirebaseCollectionsFields.messages)
          .where(FirebaseMessageFields.participantIds, arrayContains: user1.userId)
          .where(FirebaseMessageFields.participantIds, arrayContains: user2.userId)
          .orderBy(FirebaseMessageFields.sentAt, descending: true) // todo maybe false
          .snapshots()
          .transform(StreamTransformer<QuerySnapshot, List<MessageDto>>.fromHandlers(
              handleData: (snapshot, sink) {
        List<MessageDto> messages = [];

        snapshot.docs.forEach((document) {
          messages.add(MessageDto.toMessageDtoFromSnapshot(document));
        });

        sink.add(messages);
      }));
    } on FirebaseException catch (e) {
      throw InformativeException(e.message);
    }
  }

  Future<MessageDto> sendMessage(UserDto from, UserDto to, MessageDto message) async {
    try {
      // 1. get necessary chat and create message
      QueryDocumentSnapshot chatSnapshot = await createNewOrGetExistingChatSnapshot(from, to);
      ChatDto chat = ChatDto.toChatDtoFromSnapshot(chatSnapshot);
      String fieldName = chat.userIds[0] == from.userId
          ? FirebaseChatsFields.user2UnreadMessageCount
          : FirebaseChatsFields.user1UnreadMessageCount;
      int field = chat.userIds[0] == from.userId
          ? chat.user2UnreadMessageCount
          : chat.user1UnreadMessageCount;

      // 2. update firebase with new message and chat
      FirebaseFirestore.instance
          .collection(FirebaseCollectionsFields.messages)
          .add(message.copyWith(status: MessageStatus.sent).toMap());

      chatSnapshot.reference.update({
        FirebaseChatsFields.lastMessageSent: message,
        FirebaseChatsFields.lastMessageDate: message.sentAt,
        fieldName: field + 1,
      });

      // 3. return sentMessage
      return message.copyWith(status: MessageStatus.sent);
    } on FirebaseException catch (e) {
      throw InformativeException(e.message);
    }
  }

  Future<QueryDocumentSnapshot> createNewOrGetExistingChatSnapshot(
      UserDto user1, UserDto user2) async {
    try {
      // checking if chat exists, if so return it to BLoC
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollectionsFields.chats)
          .where(FirebaseChatsFields.userIds, arrayContains: user1.userId)
          .where(FirebaseChatsFields.userIds, arrayContains: user2.userId)
          .get();

      if (snapshot.docs.length > 0) {
        return snapshot.docs[0];
      }

      // if chat does not exists, create one and return to chat
      await FirebaseFirestore.instance.collection(FirebaseCollectionsFields.chats).add({
        FirebaseChatsFields.uid: null,
        FirebaseChatsFields.createdAt: DateTime.now().millisecondsSinceEpoch,
        FirebaseChatsFields.userIds: [user1.userId, user2.userId],
        FirebaseChatsFields.userNames: [user1.userName, user2.userName],
        FirebaseChatsFields.userPictures: [user1.picture, user2.picture],
        FirebaseChatsFields.user1UnreadMessageCount: 0,
        FirebaseChatsFields.user2UnreadMessageCount: 0,
        FirebaseChatsFields.lastMessageDate: null,
        FirebaseChatsFields.lastMessageSent: null,
      });

      // checking if chat exists, if so return it to BLoC
      snapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollectionsFields.chats)
          .where(FirebaseChatsFields.userIds, arrayContains: user1.userId)
          .where(FirebaseChatsFields.userIds, arrayContains: user2.userId)
          .get();

      if (snapshot.docs.length > 0) {
        return snapshot.docs[0];
      }

      throw InformativeException('Unexpected error: firebase_messages:53');
    } on FirebaseException catch (e) {
      throw InformativeException(e.message);
    }
  }
}
