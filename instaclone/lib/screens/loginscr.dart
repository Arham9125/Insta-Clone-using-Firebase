import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instaclone/resourses/auth_meth.dart';
import 'package:instaclone/responsive/mobile_Scr.dart';
import 'package:instaclone/responsive/responsivelscr.dart';
import 'package:instaclone/responsive/web_scr.dart';
import 'package:instaclone/screens/sign-up.dart';
import 'package:instaclone/utils/colors.dart';
import 'package:instaclone/utils/utlis.dart';
import 'package:instaclone/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController pass = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    pass.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res =
        await AuthMethoeds().loginscr(email: email.text, pass: pass.text);

    if (res == "Sucess") {

       Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobScreenLayout: MobileScreenLayout()))));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => Signscreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(),
                        flex: 2,
                      ),
                      SvgPicture.asset(
                        "assets/insta.svg",
                        color: primaryColor,
                        height: 64,
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      TextfieldInput(
                          hinttext: "Enter your Email",
                          controller: email,
                          isPass: false,
                          textInputType: TextInputType.emailAddress),
                      SizedBox(
                        height: 24,
                      ),
                      TextfieldInput(
                          hinttext: "Enter your Password",
                          controller: pass,
                          isPass: true,
                          textInputType: TextInputType.text),
                      SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: loginUser,
                        child: Container(
                          child: Text("Log in"),
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: ShapeDecoration(
                              color: blueColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                        ),
                      ),
                      Flexible(
                        child: Container(),
                        flex: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("Don't you have ana account? "),
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          GestureDetector(
                            onTap: navigateToSignUp,
                            child: Container(
                              child: Text(
                                "Sign-Up",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
    );
  }
}
