import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remote_patient_monitoring/clipShadowPath.dart';
import 'package:remote_patient_monitoring/home_page.dart';
import 'package:remote_patient_monitoring/values.dart';
import 'clipper.dart';

const List<Widget> genders = <Widget>[
  Text('Male'),
  Text('Female'),
];

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final contactController = TextEditingController();
  final allergyController = TextEditingController();
  String? gender;
  final List<bool> _selectedgender = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final db = FirebaseFirestore.instance;
    final curUser = FirebaseAuth.instance.currentUser;
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipShadowPath(
                clipper: CustomSignUpShapeClipper2(),
                shadow: const Shadow(blurRadius: 24, color: Color(0xFF4045EE)),
                child: Container(
                  height: heightOfScreen * 0.3,
                  width: widthOfScreen,
                  color: const Color(0xFF4045EE),
                  child: Container(
                    margin: const EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: heightOfScreen * 0.05,
                        ),
                        Text(
                          "Patient Details",
                          style: theme.textTheme.headline4?.copyWith(
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: widthOfScreen - 30,
                child: CustomTextFormField(
                  textEditingController: nameController,
                  textInputType: TextInputType.name,
                  labelText: "Name",
                  border: Borders.customOutlineInputBorder(),
                  enabledBorder: Borders.customOutlineInputBorder(),
                  focusedBorder: Borders.customOutlineInputBorder(
                    color: AppColors.violetShade200,
                  ),
                  labelStyle: Styles.customTextStyle(),
                  hintTextStyle: Styles.customTextStyle(),
                  textStyle: Styles.customTextStyle(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: widthOfScreen - 30,
                child: CustomTextFormField(
                  textEditingController: ageController,
                  textInputType: TextInputType.number,
                  labelText: "Age",
                  border: Borders.customOutlineInputBorder(),
                  enabledBorder: Borders.customOutlineInputBorder(),
                  focusedBorder: Borders.customOutlineInputBorder(
                    color: AppColors.violetShade200,
                  ),
                  labelStyle: Styles.customTextStyle(),
                  hintTextStyle: Styles.customTextStyle(),
                  textStyle: Styles.customTextStyle(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedgender.length; i++) {
                      _selectedgender[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                selectedBorderColor: Color(0xFF4045EE),
                selectedColor: Colors.white,
                fillColor: Color(0xFF4045EE),
                color: Color(0xFF4045EE),
                constraints: const BoxConstraints(
                  minHeight: 50.0,
                  maxWidth: 250,
                  minWidth: 180,
                ),
                isSelected: _selectedgender,
                children: genders,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: widthOfScreen - 30,
                child: CustomTextFormField(
                  textEditingController: contactController,
                  textInputType: TextInputType.number,
                  labelText: "Emergency Contact",
                  border: Borders.customOutlineInputBorder(),
                  enabledBorder: Borders.customOutlineInputBorder(),
                  focusedBorder: Borders.customOutlineInputBorder(
                    color: AppColors.violetShade200,
                  ),
                  labelStyle: Styles.customTextStyle(),
                  hintTextStyle: Styles.customTextStyle(),
                  textStyle: Styles.customTextStyle(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: widthOfScreen - 30,
                child: CustomTextFormField(
                  textEditingController: allergyController,
                  textInputType: TextInputType.text,
                  labelText: "Allergies(if any)",
                  border: Borders.customOutlineInputBorder(),
                  enabledBorder: Borders.customOutlineInputBorder(),
                  focusedBorder: Borders.customOutlineInputBorder(
                    color: AppColors.violetShade200,
                  ),
                  labelStyle: Styles.customTextStyle(),
                  hintTextStyle: Styles.customTextStyle(),
                  textStyle: Styles.customTextStyle(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 250,
                decoration: Decorations.customBoxDecoration(blurRadius: 10),
                child: CustomButton(
                  title: "Submit",
                  elevation: 12,
                  textStyle: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  color: AppColors.blue,
                  height: 50,
                  onPressed: () {
                    if (_selectedgender[0]) {
                      gender = 'male';
                    } else {
                      gender = 'female';
                    }
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
      ),
    );
  }
}
