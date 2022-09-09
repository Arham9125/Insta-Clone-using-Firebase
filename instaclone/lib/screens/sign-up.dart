import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclone/resourses/auth_meth.dart';
import 'package:instaclone/responsive/mobile_Scr.dart';
import 'package:instaclone/responsive/responsivelscr.dart';
import 'package:instaclone/responsive/web_scr.dart';
import 'package:instaclone/utils/colors.dart';
import 'package:instaclone/utils/utlis.dart';
import 'package:instaclone/widgets/text_field.dart';

class Signscreen extends StatefulWidget {
  @override
  State<Signscreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<Signscreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController pass = TextEditingController();

  final TextEditingController bio = TextEditingController();

  final TextEditingController username = TextEditingController();

  Uint8List? _image;

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    pass.dispose();
    bio.dispose();
    username.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => Signscreen())));
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethoeds().signUpUser(
        email: email.text,
        pass: pass.text,
        bio: bio.text,
        file: _image!,
        username: username.text);

    if (res != "Sucess") {
      showSnackBar(res, context);
      setState(() {
        _isLoading = false;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) => ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobScreenLayout: MobileScreenLayout()))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
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
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-portrait-176256935.jpg"),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: Icon(Icons.add_a_photo)))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextfieldInput(
                hinttext: "Username",
                controller: username,
                isPass: false,
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 24,
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
            TextfieldInput(
                hinttext: "Enter your Bio",
                controller: bio,
                isPass: false,
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: signUpUser,
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.red,
                    ))
                  : Container(
                      child: Text("Sign-Up"),
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
                  child: Text("Do you have an account? "),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    child: Text(
                      "Login",
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
