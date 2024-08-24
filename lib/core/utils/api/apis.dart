import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:team_app/core/utils/api/notification_access_token.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/message.dart';

class APIs {
  //for Authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestore database
  static FirebaseFirestore firesotre = FirebaseFirestore.instance;

  //for accessing firestore storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  //to return current user
  static User get user => auth.currentUser!;

  // //for storing self information
  static late ChatUser me;

  //for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessagin = FirebaseMessaging.instance;

  //for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await fMessagin.requestPermission();
    await fMessagin.getToken().then((token) {
      if (token != null) {
        me.pushToken = token;
        // log('PushToken: $token');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }

//for sending push notification
  static Future<void> sendPushNotification(
      {required ChatUser chatUser, required String msg}) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name,
          "body": msg,
          "android_channel_id": "chats",
        },
        "data": {
          "some_data": "User ID: ${me.id}",
        },
      };
      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'key=AAAAWCy6bmA:APA91bHxodG-iTXZbG08B_UwW5XuRN_7IAfhwd3MrR279cMZ2naNmE2_qBgPtky0wh6K9iG7C4DbLvYXIM9kB6DnqLmaGUuRzOOJ6Y7tQ6q92V3kNyE3T8VW_Ed1g3_t60FMH6dRI1yV'
        },
        body: jsonEncode(body),
      );
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (ex) {
      log('\n sendPushNotificationException: $ex');
    }
  }

  //for checking if user exist or not
  static Future<bool> userExists() async {
    return (await firesotre
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<ChatUser?> getUserByUid(String uid) async {
    try {
      final doc = await APIs.firesotre.collection('users').doc(uid).get();

      if (doc.exists) {
        log("doc.data() ${doc.data()}");
        return ChatUser.fromJson(doc.data()!);
      } else {
        print('No user found with this UID.');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  //for adding a chat user for our conversation
  static Future<bool> addChatUser(String email) async {
    try {
      final data = await firesotre
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      log('data : ${data.docs}');
      if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
        firesotre
            .collection('users')
            .doc(user.uid)
            .collection('my_users')
            .doc(data.docs.first.id)
            .set({});
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      log('addChatUser Exception : $ex');
      return false;
    }
  }

  //for getting current user info
  static Future<void> getSelfInfo() async {
    if (auth.currentUser != null) {
      await firesotre.collection('users').doc(auth.currentUser!.uid).get().then(
        (user) async {
          if (user.exists) {
            me = ChatUser.fromJson(user.data()!);
            await getFirebaseMessagingToken();

            //for setting user status to active
            updateActiveStatus(true);

            log('MY Data : ${user.data()}');
          } else {
            await createUser().then((value) => getSelfInfo());
          }
        },
      );
    }
  }

  //for creating a new user
  static Future<void> createUser({String? userName, int? localUserID}) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
      image: user.photoURL.toString(),
      about: "Hey, I'm using We Chat",
      name: userName ?? user.displayName.toString(),
      createdAt: time,
      id: user.uid,
      lastActive: time,
      isOnline: false,
      pushToken: '',
      email: user.email.toString(),
      localUserID: localUserID ?? -1,
    );
    return await firesotre
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  //for getting IDs of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firesotre
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

  //for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>>? getAllUsers(
      List<String> usersIDs) {
    try {
      log('Users IDs: $usersIDs');
      log('user.id ${user.uid}');

      return firesotre
          .collection('users')
          // .where('id', whereIn: usersIDs)
          .where('id', isNotEqualTo: user.uid)
          .snapshots();
    } catch (ex) {
      log('getAllUsers Exception: $ex');
      return null;
    }
  } // For getting chat users of the current user

  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatUsers(
      List<String> usersIDs) {
    try {
      log("getChatUsers ${user.uid}");
      log("${firesotre.collection('users').doc(user.uid).collection('my_users').snapshots()}");
      return firesotre
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .snapshots();
    } catch (ex) {
      log('getChatUsers Exception: $ex');
      return Stream.empty();
    }
  }

  //for adding a user to my known users when first message is sent
  static Future<void> sendFirstMessage(
      ChatUser chatUser, String msg, Type type) async {
    try {
      log("sendFirstMessage ${chatUser.name}  ${me.name}");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .doc(chatUser.id)
          .set({
        'image': chatUser.image,
        'about': chatUser.about,
        'name': chatUser.name,
        'createdAt': chatUser.createdAt,
        'id': chatUser.id,
        'lastActive': chatUser.lastActive,
        'isOnline': chatUser.isOnline,
        'push_token': chatUser.pushToken,
        'email': chatUser.email,
        'localUserID': chatUser.localUserID
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(chatUser.id) //زبون
          .collection('my_users')
          .doc(user.uid) //فرسق
          .set({
        'image': user.photoURL,
        'about': me.about,
        'name': me.name,
        'createdAt': me.createdAt,
        'id': user.uid,
        'lastActive': me.lastActive,
        'isOnline': me.isOnline,
        'push_token': me.pushToken,
        'email': user.email,
        'localUserID': me.localUserID
      });

      await sendMessage(chatUser, msg, type);
    } catch (e) {
      log("sendFirstMessage Exception: $e");
    }
  }

  //for updating user info
  static Future<void> updateUserInfo() async {
    await firesotre.collection('users').doc(user.uid).update(
      {
        'name': me.name,
        'about': me.about,
      },
    );
  }

  //for updating profile picture of user
  static Future<void> updateProfilePicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log('Extension : $ext');

    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    //uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then(
      (p0) {
        log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
      },
    );

    //updating image in firestore database
    me.image = await ref.getDownloadURL();
    await firesotre
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
  }

  //for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>>? getUserInfo(
      ChatUser chatUser) {
    try {
      return firesotre
          .collection('users')
          .where('id', isEqualTo: chatUser.id)
          .snapshots();
    } catch (ex) {
      log('getUserInfo Exception: $ex');
      return null;
    }
  }

  //update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    firesotre.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  /////////////// ***Chat View Related APIs***///////////////////////

  // chats(collection) --> conversation_id(doc) --> messages(collection) --> message(doc)

  //useful for getting conversation_id
  // static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
  //     ? '${user.uid}_$id'
  //     : '${id}_${user.uid}';

  static int getStringHashCode(String string) {
    int hash = 0;
    for (int i = 0; i < string.length; i++) {
      hash = 0x1fffffff & (hash + string.codeUnitAt(i));
      hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
      hash = hash ^ (hash >> 6);
    }
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }

  static String getConversationID(String id) {
    final myUserIDHashCode = getStringHashCode(user.uid);
    final idHashCode = getStringHashCode(id);

    return myUserIDHashCode <= idHashCode
        ? '${user.uid}_$id'
        : '${id}_${user.uid}';
  }

  //for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firesotre
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  //for sending message
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Message message = Message(
        msg: msg,
        read: '',
        toId: chatUser.id,
        type: type,
        fromId: user.uid,
        sent: time);
    final ref = firesotre
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson()).then(
      (value) {
        sendPushNotification(
          chatUser: chatUser,
          msg: type == Type.text ? msg : 'Sent an image',
        );
      },
    );
  }

  //update read status for message
  static Future<void> updateMessageReadStatus(Message message) async {
    firesotre
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessages(
      ChatUser user) {
    return firesotre
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //for sending an image
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    try {
      //getting image file extension
      final ext = file.path.split('.').last;

      //storage file ref with path
      final ref = storage.ref().child(
          'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

      //uploading image
      await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then(
        (p0) {
          log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
        },
      );

      //updating image in firestore database
      final imageURL = await ref.getDownloadURL();
      await sendMessage(chatUser, imageURL, Type.image);
    } catch (ex) {
      log('Send Chat Image Exception: $ex');
    }
  }

  //for delete a message
  static Future<void> deleteMessage(Message message) async {
    await firesotre
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == Type.image) {
      await storage.refFromURL(message.msg).delete();
    }
  }

  //for update a message
  static Future<void> updateMessage(Message message, String updatedMsg) async {
    await firesotre
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .update({'msg': updatedMsg});
  }

  ///////////////////
  //create user with email and password
  static Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  //login with email and password
  static Future<UserCredential?> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
    return null;
  }
}
