import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remote_patient_monitoring/home_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final allergyController = TextEditingController();
  String? gender;

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final curUser = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome!",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Please fill the details of the patient",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Enter the name",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                cursorColor: Colors.black87,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Name of the patient'),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Enter the age",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: ageController,
                cursorColor: Colors.black87,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Age of the patient'),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Select Gender",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Column(
              children: [
                RadioListTile(
                  title: Text("Male"),
                  value: "male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text("Female"),
                  value: "female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Allergies (if any)",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: allergyController,
                cursorColor: Colors.black87,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: Colors.greenAccent), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: Colors.greenAccent), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  minimumSize: Size.fromHeight(50),
                ),
                icon: const Icon(
                  Icons.send_rounded,
                  size: 32,
                ),
                label: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  final user = <String, dynamic>{
                    "name": nameController.text.trim(),
                    "age": ageController.text.trim(),
                    "gender": gender,
                    "allergies": allergyController.text.trim(),
                  };
                  db.collection("users").doc(curUser?.uid).set(user);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
