import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telegram_clone/common/constants/firebase_keys.dart';
import 'package:telegram_clone/common/constants/shared_prefs_keys.dart';
import 'package:telegram_clone/common/exceptions/informative_exception.dart';
import 'package:telegram_clone/data/storage_service.dart';
import 'package:telegram_clone/models/active_user_dto.dart';

enum FirebaseAuthUserEmailStateEnum {
  login,
  register,
  error,
}

class FirebaseAuthentication {
  Future<FirebaseAuthUserEmailStateEnum> verifyEmail(
    String email,
  ) async {
    try {
      var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        return FirebaseAuthUserEmailStateEnum.login;
      } else {
        return FirebaseAuthUserEmailStateEnum.register;
      }
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthUserEmailStateEnum.error;
    }
  }

  Future<ActiveUserDto> registerEmailAndSaveActiveUser(
      String email, String password, String userName, String picture) async {
    try {
      // Register new user in firebase
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user.updateProfile(displayName: userName);

      int joinedTime = DateTime.now().millisecondsSinceEpoch;
      // Save new user in firebase
      FirebaseFirestore.instance.collection(FirebaseCollectionsFields.users).add({
        FirebaseUsersFields.userId: FirebaseAuth.instance.currentUser.uid,
        FirebaseUsersFields.email: email,
        FirebaseUsersFields.userName: userName,
        FirebaseUsersFields.picture: picture,
        FirebaseUsersFields.joinedAt: joinedTime,
        FirebaseUsersFields.unReadMessageIds: [],
        FirebaseUsersFields.chatIds: [],
      });

      // Save new user to shared preferences
      StorageService.saveData(SharedPrefsKeys.USER_ID_KEY, FirebaseAuth.instance.currentUser.uid);
      StorageService.saveData(SharedPrefsKeys.USER_EMAIL_KEY, email);
      StorageService.saveData(SharedPrefsKeys.USERNAME_KEY, userName);
      StorageService.saveData(SharedPrefsKeys.USER_PICTURE_KEY, picture);
      StorageService.saveData(SharedPrefsKeys.JOINED_AT_KEY, joinedTime);

      // return active user
      return ActiveUserDto(
        userId: FirebaseAuth.instance.currentUser.uid,
        userName: userName,
        email: email,
        picture: picture,
        joinedAt: joinedTime,
        chatIds: null,
        unReadMessageIds: null,
      );
    } on FirebaseException catch (e) {
      throw InformativeException(e.message);
    }
  }

  Future<ActiveUserDto> loginWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      QuerySnapshot data = await FirebaseFirestore.instance
          .collection(FirebaseCollectionsFields.users)
          .where(FirebaseUsersFields.email, isEqualTo: email)
          .get();

      if (data.docs == null || data.docs.length == 0) {
        throw InformativeException('Sorry unexpected error');
      }

      QueryDocumentSnapshot doc = data.docs[0];

      ActiveUserDto activeUserDto = ActiveUserDto(
        userId: doc[FirebaseUsersFields.userId],
        userName: doc[FirebaseUsersFields.userName],
        email: doc[FirebaseUsersFields.email],
        picture: doc[FirebaseUsersFields.picture],
        joinedAt: doc[FirebaseUsersFields.joinedAt],
        chatIds: doc[FirebaseUsersFields.chatIds],
        unReadMessageIds: doc[FirebaseUsersFields.unReadMessageIds],
      );

      // Save new user to shared preferences
      StorageService.saveData(SharedPrefsKeys.USER_ID_KEY, activeUserDto.userId);
      StorageService.saveData(SharedPrefsKeys.USER_EMAIL_KEY, activeUserDto.email);
      StorageService.saveData(SharedPrefsKeys.USERNAME_KEY, activeUserDto.userName);
      StorageService.saveData(SharedPrefsKeys.USER_PICTURE_KEY, activeUserDto.picture);
      StorageService.saveData(SharedPrefsKeys.JOINED_AT_KEY, activeUserDto.joinedAt);

      return activeUserDto;
    } on FirebaseAuthException catch (e) {
      throw InformativeException(e.message);
    } on InformativeException catch (e) {
      throw InformativeException(e.message);
    }
  }

  Future<void> logout() async {
    try {
      // Save new user to shared preferences
      StorageService.saveData(SharedPrefsKeys.USER_ID_KEY, null);
      StorageService.saveData(SharedPrefsKeys.USER_EMAIL_KEY, null);
      StorageService.saveData(SharedPrefsKeys.USERNAME_KEY, null);
      StorageService.saveData(SharedPrefsKeys.USER_PICTURE_KEY, null);
      StorageService.saveData(SharedPrefsKeys.JOINED_AT_KEY, null);

      // logout from firebase
      await FirebaseAuth.instance.signOut();
    } on FirebaseException catch (e) {
      throw InformativeException(e.message);
    }
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
///
///
///
