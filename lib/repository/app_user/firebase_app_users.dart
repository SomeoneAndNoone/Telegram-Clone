import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telegram_clone/common/constants/firebase_keys.dart';
import 'package:telegram_clone/models/user_dto.dart';

class FirebaseAppUsers {
  Stream<List<UserDto>> getAppUsersSubscription(String activeUserEmail) {
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionsFields.users)
        .where(FirebaseUsersFields.email, isNotEqualTo: activeUserEmail)
        .snapshots()
        .transform(_streamTransformer);
  }

  final _streamTransformer =
      StreamTransformer<QuerySnapshot, List<UserDto>>.fromHandlers(handleData: (snapshot, sink) {
    List<UserDto> users = [];
    snapshot.docs.forEach((document) {
      users.add(
        UserDto(
          userId: document.data()[FirebaseUsersFields.userId],
          joinedAt: document.data()[FirebaseUsersFields.joinedAt],
          userName: document.data()[FirebaseUsersFields.userName],
          picture: document.data()[FirebaseUsersFields.picture],
        ),
      );
    });

    sink.add(users);
  });
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
