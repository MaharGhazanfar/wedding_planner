import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../modelClasses/model_personal_login_info.dart';
import 'data_constants.dart';

class DBHandler {
  static var user = FirebaseAuth.instance.currentUser;

  static CollectionReference personalInfoCollectionForProvider() {
    return FirebaseFirestore.instance.collection(Strings.serviceProvider);
  }

  static CollectionReference photosCollection({required String UID}) {
    return FirebaseFirestore.instance
        .collection(Strings.serviceProvider)
        .doc(UID != ''
            ? UID
            : ModelPersonalLoginInfo.prefs!.getString(
                  Strings.UIDPref,
                ) ??
                user!.uid)
        .collection('Photos');
  }

  static CollectionReference videosCollection({required String UID}) {
    return FirebaseFirestore.instance
        .collection(Strings.serviceProvider)
        .doc(UID != ''
            ? UID
            : ModelPersonalLoginInfo.prefs!.getString(
                  Strings.UIDPref,
                ) ??
                user!.uid)
        .collection('Videos');
  }

  static CollectionReference blogsPost() {
    return FirebaseFirestore.instance.collection(Strings.blogPost);
  }

  static CollectionReference generalPackagesCollection() {
    return FirebaseFirestore.instance
        .collection(Strings.generalPackageCollection);
  }

  static CollectionReference providerPackages({required String UID}) {
    return FirebaseFirestore.instance
        .collection(Strings.serviceProvider)
        .doc(UID != ''
            ? UID
            : ModelPersonalLoginInfo.prefs!.getString(
                  Strings.UIDPref,
                ) ??
                user!.uid)
        .collection(Strings.providerPackages);
  }

  /// User Section

  static CollectionReference chatsUserList() {
    return FirebaseFirestore.instance.collection(Strings.chats);
  }

  static CollectionReference personalInfoCollectionForServiceUser() {
    return FirebaseFirestore.instance.collection(Strings.serviceUser);
  }

  static CollectionReference usersTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Strings.serviceUser)
        .doc(user!.uid)
        .collection(Strings.userPersonalTasks);
  }

  static CollectionReference usersFavouritePackagesCollection() {
    return FirebaseFirestore.instance
        .collection(Strings.serviceUser)
        .doc(user!.uid)
        .collection(Strings.userFavouriteItems);
  }
}
