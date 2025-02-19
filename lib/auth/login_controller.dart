
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skill_test/model/user_model.dart';
import 'package:skill_test/route/routes.dart';
import 'package:skill_test/service/local_storge.dart';

class LoginController extends GetxController {

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController adminPhoneController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();


  Future<void> login() async{
    var firebaseInstance = FirebaseFirestore.instance;
   var result = await firebaseInstance.collection('candidate').where(
      'mobile', isEqualTo: phoneController.text,
    ).where(
      'password', isEqualTo: passwordController.text
    ).get();
   if(result.docs.isNotEmpty){
     LocalStorage.setUserData(UserModel(
       name: result.docs.first['name'] ?? '',
       mobile: result.docs.first['mobile'],
       password: result.docs.first['password'],
       isAdmin: false,
       testName: result.docs.first['testName'],
     ));
     Get.offAndToNamed(Routes.home);
   }else{
     Get.snackbar('Error', 'Invalid Credentials');
   }
  }

  Future<void> adminLogin() async{
    var firebaseInstance = FirebaseFirestore.instance;
    var result = await firebaseInstance.collection('admin').where(
      'mobile', isEqualTo: adminPhoneController.text,
    ).where(
      'password', isEqualTo: adminPasswordController.text
    ).get();
    if(result.docs.isNotEmpty){
      LocalStorage.setUserData(UserModel(
        name: result.docs.first['name'],
        mobile: result.docs.first['mobile'],
        password: result.docs.first['password'],
        isAdmin: true,
      ));
      Get.offAllNamed(Routes.adminHome);
    }else{
      Get.snackbar('Error','Admin Login is wrong');
    }
  }
}