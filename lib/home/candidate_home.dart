import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test/home/controller/candidate_home_controller.dart';
import 'package:skill_test/service/local_storge.dart';
import 'package:skill_test/utils/size_utils.dart';

import '../route/routes.dart';

class CandidateHome extends StatefulWidget {
  const CandidateHome({super.key});

  @override
  State<CandidateHome> createState() => _CandidateHomeState();
}

class _CandidateHomeState extends State<CandidateHome> {

  final controller = Get.find<CandidateHomeController>();
@override
  void initState() {
  controller.getTest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidate Home'),
        actions: [OutlinedButton(onPressed: (){
          LocalStorage.clear();
          Get.offAllNamed(Routes.login);
        }, child: const Text('Logout'))],
      ),
      body: Padding(
        padding: context.padding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(),
              Text('Candidate Name : ${LocalStorage.userData().name}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              Text('Candidate Mobile : ${LocalStorage.userData().mobile}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              Text('Candidate Test Name : ${LocalStorage.userData().testName}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text('Instruction : ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Obx(()=>ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:controller.testData.value.instruction?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${index + 1} : ${controller.testData.value.instruction?[index]}'),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
             LocalStorage.getInt('total') ==0 ? OutlinedButton(onPressed:(){
                Get.offNamedUntil(Routes.testPage, (route) => false);
              }, child: const Text('Start Test')) : Text('Your Score : ${LocalStorage.getInt('total')} Points',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color: Colors.green),),
            ],
          ),
        ),)
    );
  }
}
