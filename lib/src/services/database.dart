import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
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

  // getQuizData() async{
  //   return await FirebaseFirestore.instance.collection(@Qu)
  // }

  // Future<void> addQuizData(Map quizData, String quizId) async {
  //   await FirebaseFirestore.instance.collection(collectionPath)
  // }

}
