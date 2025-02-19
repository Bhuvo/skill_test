import 'package:get/get.dart';
import '../auth/login_controller.dart';
import '../home/controller/admin_home_controller.dart';
import '../home/controller/candidate_home_controller.dart';
class InjectorService {
  static Future<void> inject() async {
   await  Get.put(LoginController());
   await  Get.put(AdminHomeController());
   await  Get.put(CandidateHomeController());
  }
}