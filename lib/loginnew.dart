import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';
import 'values.dart';
import 'clipShadowPath.dart';

class LoginScreen4 extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginScreen4({Key? key, required this.onClickedSignUp})
      : super(key: key);
  @override
  _LoginScreen4State createState() => _LoginScreen4State();
}

class _LoginScreen4State extends State<LoginScreen4> {
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
                shadow: Shadow(blurRadius: 24, color: AppColors.blue),
                child: Container(
                  height: heightOfScreen * 0.4,
                  width: widthOfScreen,
                  color: AppColors.blue,
                  child: Container(
                    margin: EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: heightOfScreen * 0.1,
                        ),
                        Text(
                          "Welcome Back",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 20,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "Login",
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: AppColors.white,
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
          labelText: "Email",
          border: Borders.customOutlineInputBorder(),
          enabledBorder: Borders.customOutlineInputBorder(),
          focusedBorder: Borders.customOutlineInputBorder(
            color: AppColors.violetShade200,
          ),
          labelStyle: Styles.customTextStyle(),
          hintTextStyle: Styles.customTextStyle(),
          textStyle: Styles.customTextStyle(),
        ),
        SizedBox(
          height: 20,
        ),
        CustomTextFormField(
          textEditingController: passwordController,
          textInputType: TextInputType.text,
          labelText: "Password",
          obscured: true,
          hasSuffixIcon: true,
          suffixIcon: Icon(
            FeatherIcons.lock,
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
        SizedBox(
          height: 12,
        ),
        Row(
          children: <Widget>[
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              activeTrackColor: AppColors.greyShade6,
              activeColor: AppColors.blue,
            ),
            Text(
              "Remember me",
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.blackShade10,
                fontSize: 14,
              ),
            ),
            Spacer(flex: 1),
            Text(
              "Forgot Password",
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.blackShade10,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: 250,
          decoration: Decorations.customBoxDecoration(blurRadius: 10),
          child: CustomButton(
            title: "Login",
            elevation: 8,
            textStyle: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            color: AppColors.blue,
            height: 50,
            onPressed: signIn,
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
            title: "Sign In with Google",
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
          onTap: widget.onClickedSignUp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "New User?",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.blackShade9,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Sign Up",
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

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
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
