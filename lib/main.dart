import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remote_patient_monitoring/auth_page.dart';
import 'package:remote_patient_monitoring/login.dart';
import 'package:remote_patient_monitoring/loginnew.dart';
import 'package:remote_patient_monitoring/signupnew.dart';
import 'home_page.dart';
import 'form_page.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Something Went Wrong!"),
              );
            } else if (snapshot.hasData) {
              CollectionReference users =
                  FirebaseFirestore.instance.collection('users');

              return FutureBuilder<DocumentSnapshot>(
                future: users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return FormPage();
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return Home();
                  }
                  return Text("no data");
                },
              );
            } else {
              return AuthPage();
            }
          },
        ),
      ),
    );
  }
}
