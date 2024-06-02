import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:foodie/Firestore/Utilities.dart';

enum Collections { users }

class FirestoreService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAll(
      Collections colEnum) async {
    final String colName = colEnum.name;
    final col = firestore.collection(colName);
    final QuerySnapshot<Map<String, dynamic>> colQuery = await col.get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> colDocs =
        colQuery.docs;
    return colDocs;

  }

  // static Future<void> getData() async {
  //   FirebaseAuth.instance.signInWithEmailAndPassword(email: 'email', password: 'password').then((value) {});
  //   FirebaseAuth.instance.createUserWithEmailAndPassword(email: '', password: ;).then((value) {
  //     await FirebaseFirestore.instance.collection('das').doc(value.id).set({
  //       'name': 'dabisud', 'emaik': '', 'phine': '','uid':"${value.id}"
  //     });
  //   })
  //
  //   await FirebaseFirestore.instance.collection('das').add({
  //     'name': 'dabisud', 'id': '', 'phine': '','uid':""
  //   }).then((value)async{
  //     await FirebaseFirestore.instance.collection('das').doc(value.id).update({
  //       'name':"dash"
  //     });
  //   });
  // }
}

class UserModel {
  //List<ExamModel>? students;
  String? uid;

  String? name;
  String? email;
  String? password;
  String? gender;
  // Constructor
  UserModel({
    //required this.students,
    required this.uid,
    required this.email,
    required this.password,
    required this.name,
    required this.gender,
  });

  // Factory method to create a User object from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(

      //  students: List<Student_Model>.from(json['students'] as List<Student_Model>),
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      uid: json['uid'],
      name: json['name'],
    );
  }

  // Method to convert a User object to a JSON map
  Map<String, dynamic> toJson() {
    //  dynamic studentsJson = students?.map((student) => student.toJson()).toList() ?? [];

    return {
      'name': name,
      'uid': uid,
      'gender': gender,
      'password': password,
      'email': email,
      // 'students': studentsJson,
    };
  }
}
