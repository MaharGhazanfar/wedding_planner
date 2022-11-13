import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../modelClasses/model_personal_login_info.dart';
import 'data_constants.dart';

class DBHandler {
  static var user = FirebaseAuth.instance.currentUser;

  static CollectionReference personalInfoCollectionForProvider() {
    return FirebaseFirestore.instance.collection(Strings.serviceProvider);
  }

  static CollectionReference personalInfoCollectionForServiceUser() {
    return FirebaseFirestore.instance.collection(Strings.serviceUser);
  }

  static CollectionReference photosCollection() {
    return FirebaseFirestore.instance
        .collection(Strings.serviceProvider)
        .doc(ModelPersonalLoginInfo.prefs!.getString(Strings.UIDPref,) == null  ? user!.uid : ModelPersonalLoginInfo.prefs!.getString(Strings.UIDPref,))
        .collection('Photos');
  }

  static CollectionReference videosCollection() {
    return FirebaseFirestore.instance
        .collection(Strings.serviceProvider)
        .doc(ModelPersonalLoginInfo.prefs!.getString(Strings.UIDPref,) == null  ? user!.uid : ModelPersonalLoginInfo.prefs!.getString(Strings.UIDPref,))
        .collection('Videos');
  }

  static CollectionReference blogsPost() {
    return FirebaseFirestore.instance.collection(Strings.blogPost);
  }
}
