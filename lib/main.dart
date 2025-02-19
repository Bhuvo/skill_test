import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test/auth/login.dart';
import 'package:skill_test/route/router.dart';
import 'package:skill_test/route/routes.dart';
import 'package:skill_test/service/local_storge.dart';
import 'package:skill_test/service/service.dart';

import 'service/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FireBaseService.initFirebase();
  LocalStorage.init();
 await InjectorService.inject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: MRouter.route,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }
  isLoggedIn() async{
    await Future.delayed(Duration(seconds: 2));
    if(LocalStorage.userExist()){
      if(LocalStorage.userData().isAdmin == true){
        Get.offAndToNamed(Routes.adminHome);
      }else{
        Get.offAndToNamed(Routes.home);
      }
    }else{
      Get.offAndToNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}


