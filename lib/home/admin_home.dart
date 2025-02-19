import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test/service/local_storge.dart';
import 'package:skill_test/utils/size_utils.dart';

import '../route/routes.dart';
import '../widget/m_drawer.dart';
import 'controller/admin_home_controller.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  final controller = Get.find<AdminHomeController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String testName = '';
  @override
  void initState() {
    controller.getTest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        actions: [OutlinedButton(onPressed: (){
          LocalStorage.clear();
          Get.offAllNamed(Routes.login);
        }, child: const Text('Logout'))],
      ),
      body: Padding(
        padding: context.padding,
        child: Column(
          children: [
            Row(),
            Text('Assign Candidates',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text('Candidate Name'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: mobileController,
              decoration: InputDecoration(
                label: Text('Candidate mobile'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                label: Text('Candidate password'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            MDropDown(items: controller.data ,onItemChanged: (value){testName = value;},),
            SizedBox(height: 20,),
            OutlinedButton(onPressed: (){
              controller.assignTest(nameController.text,mobileController.text, passwordController.text, testName);
              mobileController.clear();
              passwordController.clear();
              }, child: Text('Assign'))
          ],
        ),
      ),
    );
  }
}
