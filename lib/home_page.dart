import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'object_detector_view.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Remote Patient Monitoring'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text("Welcome " + user.email!),
                  SizedBox(
                    height: 20,
                  ),
                  CustomCard('Object Detection', ObjectDetectorView()),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    icon: Icon(
                      Icons.lock_outline,
                      size: 20,
                    ),
                    label: Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      signOut(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signOut(BuildContext context) async {
    print("here");
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final Widget _viewPage;
  final bool featureCompleted;

  const CustomCard(this._label, this._viewPage, {this.featureCompleted = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (!featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    const Text('This feature has not been implemented yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
      ),
    );
  }
}
