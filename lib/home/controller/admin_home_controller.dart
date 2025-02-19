import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/test_model.dart';

class AdminHomeController extends GetxController{
  List<String> data =[];

  Future<void> getTest()async{
    final result = await FirebaseFirestore.instance.collection('test').get();
    if(result.docs.isNotEmpty){
      data = result.docs.map((e) => TestModel.fromJson(e.data()).toString()).toList();
    }
    print('the length is ${data.length}');
  }

  Future<void> assignTest(String name ,String mobile ,String password ,String testName)async{
    final result = await FirebaseFirestore.instance.collection('candidate').add(
      {
        'name':name,
        'mobile':mobile,
        'password':password,
        'testName':testName
      }
    );
    if(result.id.isNotEmpty){
      Get.snackbar('Success', 'Candidate assigned successfully');
    }
  }
}