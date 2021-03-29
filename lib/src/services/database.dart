import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> getUser(String email, String password) async {
    var query = FirebaseFirestore.instance
        .collection("QuizMaker")
        .where('user', isEqualTo: email)
        .where('password', isEqualTo: password);

    query.get().then((value) {
      //print('DEJAMEEEEEE ${value.docs}'); saber como imprimir esto
    });
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

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quizes").snapshots();
  }

  // Future<void> addQuizData(Map quizData, String quizId) async {
  //   await FirebaseFirestore.instance.collection(collectionPath)
  // }

}
