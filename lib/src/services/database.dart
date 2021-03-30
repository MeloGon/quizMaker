import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future getUser(String email, String password) async {
    var query = await FirebaseFirestore.instance
        .collection("QuizMaker")
        .where('user', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (query.size > 0) {
      return true;
    } else {
      return false;
    }

    // query.get().then((value) {
    //   if (value.docs[0]['userId'] != null) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    //   //print('DEJAMEEEEEE ${value.docs[0]['username']}');
    // });
  }

  Future<String> getIdUser(String email, String password) async {
    String id;
    await FirebaseFirestore.instance
        .collection("QuizMaker")
        .where('user', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        //print('ELEMENTO' + element["userId"]);
        id = element["userId"];
      });
    });

    return id;
  }

  Future<void> createUser(Map userData, String userId) async {
    await FirebaseFirestore.instance
        .collection("QuizMaker")
        .doc(userId)
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuizData(Map quizData, String userId, String quizId) async {
    await FirebaseFirestore.instance
        .collection("QuizMaker")
        .doc(userId)
        .collection("Quizes")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(
      Map questionData, String userId, String quizId) async {
    await FirebaseFirestore.instance
        .collection("QuizMaker")
        .doc(userId)
        .collection("Quizes")
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizData(String userId) async {
    return await FirebaseFirestore.instance
        .collection("QuizMaker")
        .doc(userId)
        .collection("Quizes")
        .snapshots();
  }

  // Future<void> addQuizData(Map quizData, String quizId) async {
  //   await FirebaseFirestore.instance.collection(collectionPath)
  // }

}
