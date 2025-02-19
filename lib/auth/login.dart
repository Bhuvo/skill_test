import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test/route/routes.dart';
import 'package:skill_test/utils/size_utils.dart';
import '../route/router.dart';
import 'login_controller.dart';

class Login extends StatelessWidget {
   Login({super.key});

  final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          OutlinedButton(onPressed: (){
            Get.toNamed(Routes.adminLogin);
          }, child: const Text('Admin'))
        ],
      ),
      body: Padding(
        padding: context.padding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              TextFormField(
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  label: Text('Mobile Number'),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
              ),
              SizedBox(height: 10,),
              OutlinedButton(onPressed: (){
                controller.login();
              }, child: const Text('Login'))
            ],
          )
        ),
      ),
    );
  }
}
