class FirebaseCollectionsFields {
  // collections
  static String users = 'users';
  static String messages = 'messages';
  static String chats = 'chats';
}

class FirebaseUsersFields {
  static String userId = 'userId';
  static String joinedAt = 'joinedAt';
  static String userName = 'userName';
  static String picture = 'picture';
  static String email = 'email';
  static String unReadMessageIds = 'unReadMessageIds';
  static String chatIds = 'chatIds';
}

class FirebaseChatsFields {
  static String uid = 'uid';
  static String createdAt = 'createdAt';
  static String userIds = 'userIds';
  static String userNames = 'userNames';
  static String userPictures = 'userPictures';
  static String user1UnreadMessageCount = 'user1UnreadMessageCount';
  static String user2UnreadMessageCount = 'user2UnreadMessageCount';
  static String lastMessageDate = 'lastMessageDate';
  static String lastMessageSent = 'lastMessageSent';
}

class FirebaseMessageFields {
  static String uid = 'uid';
  static String chatId = 'chatId';
  static String message = 'message';
  static String sentAt = 'sentAt';
  static String status = 'status';
  static String ownerId = 'ownerId';
  static String ownerName = 'ownerName';
  static String ownerPicture = 'ownerPicture';
  static String receiverId = 'receiverId';
  static String isDeleted = 'isDeleted';
  static String participantIds = 'participants';
}
