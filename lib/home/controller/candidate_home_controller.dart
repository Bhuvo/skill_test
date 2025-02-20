import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skill_test/service/local_storge.dart';

import '../../model/test_model.dart';

class CandidateHomeController extends GetxController{

  Rx<TestModel> testData = TestModel().obs;

  Future<void> getTest()async{
    print('the test is coming');
    final result = await FirebaseFirestore.instance.collection('test').where(
      'title',isEqualTo: LocalStorage.userData().testName
    ).get();
    if(result.docs.isNotEmpty){
      testData.value = TestModel.fromJson(result.docs.first.data());
      var questions = await FirebaseFirestore.instance.collection('test').doc(result.docs.first.id).collection('questions').orderBy(
        'order' ,descending: false
      ).get();
   testData.value.questions = questions.docs.map((e) {
     // print('the question is ${e.data()}');
     return QuestionModel.fromJson(e.data());
   }).toList();
    LocalStorage.setString(LocalStorage.testData, jsonEncode(testData.value.toJson()));
    }
  }


}