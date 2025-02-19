import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test/auth/login_controller.dart';
import 'package:skill_test/utils/size_utils.dart';

class AdminLogin extends StatelessWidget {
   AdminLogin({super.key});

   final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Admin Login'),
      ),
      body: Padding(
        padding: context.padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            TextFormField(
              controller: controller.adminPhoneController,
              decoration: InputDecoration(
                label: Text('Mobile Number'),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: controller.adminPasswordController,
              decoration: InputDecoration(
                label: Text('Password'),
              ),
            ),
            SizedBox(height: 10,),
            OutlinedButton(onPressed: controller.adminLogin, child: Text('Login'))
          ],
        ),
      ),
    );
  }
}
