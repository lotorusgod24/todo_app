import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreApi {
  static DateTime now = DateTime.now();
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users').doc().collection('task');

  static Future createNewTask({required String task}) async {
    await userCollection.add({
      'taskId': userCollection.doc().id,
      'task': task,
      'createdAt': now,
      'taskStatrTime':
          DateTime(now.year, now.month, now.day, now.hour, now.minute),
      'taskEndTime':
          DateTime(now.year, now.month, now.day, now.hour + 2, now.minute + 5),
    });
  }

  static Future deleteTask() async {
    await userCollection.doc().delete();
  }

  // List<UserModel>? usersFromFirestore(QuerySnapshot snapshot) {
  //   if (snapshot != null)
  //     return snapshot.docs.map((e) {
  //       return UserModel(uid: userCollection.doc().id);
  //     }).toList();
  //   else {
  //     return null;
  //   }
  // }
}
