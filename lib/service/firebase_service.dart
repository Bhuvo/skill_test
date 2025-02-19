import 'package:firebase_core/firebase_core.dart';

class FireBaseService{

  static const String candidate = "candidate";

 static Future<void> initFirebase ()async{
    Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyBZmtHRQqYHzfeIYxjp_SNX445Ws3ob-Uw",
      appId: '1:697473421383:android:0d347b2e6560dcc938a162',
      messagingSenderId: '697473421383', projectId: 'app1-926c8'
    ));
  }
}