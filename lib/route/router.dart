import 'package:get/get.dart';
import 'package:skill_test/auth/admin_login.dart';
import 'package:skill_test/home/admin_home.dart';
import 'package:skill_test/route/routes.dart';

import '../auth/login.dart';
import '../home/candidate_home.dart';
import '../test_module/test_page.dart';

class MRouter{
 static List<GetPage<dynamic>> route =[
  GetPage(name: Routes.adminLogin, page: () => AdminLogin()),
  GetPage(name: '/', page: () => Login()),
  GetPage(name: Routes.adminHome, page: () => AdminHome()),
  GetPage(name: Routes.home, page: () => CandidateHome()),
  GetPage(name: Routes.testPage, page: () => TestPage()),

 ];
}