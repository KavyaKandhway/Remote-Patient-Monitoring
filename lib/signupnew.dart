import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';
import 'values.dart';
import 'clipShadowPath.dart';

class SignUpScreen4 extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpScreen4({Key? key, required this.onClickedSignIn})
      : super(key: key);
  @override
  _SignUpScreen4State createState() => _SignUpScreen4State();
}

class _SignUpScreen4State extends State<SignUpScreen4> {
  bool isSwitched = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              ClipShadowPath(
                clipper: LoginDesign4ShapeClipper(),
                shadow: const Shadow(blurRadius: 24, color: Color(0xFF4045EE)),
                child: Container(
                  height: heightOfScreen * 0.4,
                  width: widthOfScreen,
                  color: const Color(0xFF4045EE),
                  child: Container(
                    margin: const EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: heightOfScreen * 0.1,
                        ),
                        Text(
                          "Hello,",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 20,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                        Text(
                          "Sign Up!",
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  SizedBox(
                    height: heightOfScreen * 0.45,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: _buildForm(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    ThemeData theme = Theme.of(context);
    return Column(
      children: <Widget>[
        CustomTextFormField(
          textEditingController: emailController,
          textInputType: TextInputType.text,
          labelText: "Email Address",
          border: Borders.customOutlineInputBorder(),
          enabledBorder: Borders.customOutlineInputBorder(),
          focusedBorder: Borders.customOutlineInputBorder(
            color: AppColors.violetShade200,
          ),
          labelStyle: Styles.customTextStyle(),
          hintTextStyle: Styles.customTextStyle(),
          textStyle: Styles.customTextStyle(),
        ),
        const SizedBox(
          height: 20.0,
        ),
        CustomTextFormField(
          textEditingController: passwordController,
          textInputType: TextInputType.text,
          labelText: "Password",
          obscured: true,
          hasSuffixIcon: true,
          suffixIcon: const Icon(
            Icons.lock,
            color: AppColors.blackShade10,
          ),
          border: Borders.customOutlineInputBorder(),
          enabledBorder: Borders.customOutlineInputBorder(),
          focusedBorder: Borders.customOutlineInputBorder(
            color: AppColors.violetShade200,
          ),
          labelStyle: Styles.customTextStyle(),
          hintTextStyle: Styles.customTextStyle(),
          textStyle: Styles.customTextStyle(),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: 250,
          decoration: Decorations.customBoxDecoration(blurRadius: 10),
          child: CustomButton(
            title: "Sign Up",
            elevation: 12,
            textStyle: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            color: AppColors.blue,
            height: 50,
            onPressed: signUp,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 80,
                  height: 1,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text("OR", style: theme.textTheme.titleMedium),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Container(
                  width: 80,
                  height: 1,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: 250,
          decoration: Decorations.customBoxDecoration(blurRadius: 10),
          child: CustomButton(
            title: "Register with Google",
            textStyle: theme.textTheme.titleMedium,
            hasIcon: true,
            color: AppColors.white,
            onPressed: signInWithGoogle,
            icon: Image.asset(
              "assets/google.png",
              height: 25,
              width: 25,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: widget.onClickedSignIn,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Already Registered?",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.blackShade9,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Log In",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.lightBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
