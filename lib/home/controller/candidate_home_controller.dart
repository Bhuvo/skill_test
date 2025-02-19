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
    }
    print('the length is ${testData.value.instruction?.length}');
  }
}