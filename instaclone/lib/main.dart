import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/providers/provider.dart';
import 'package:instaclone/responsive/mobile_Scr.dart';
import 'package:instaclone/responsive/responsivelscr.dart';
import 'package:instaclone/responsive/web_scr.dart';
import 'package:instaclone/screens/loginscr.dart';
import 'package:instaclone/screens/sign-up.dart';
import 'package:instaclone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: "AIzaSyAhZJb3QwC65JBUxfZuxZJjy6cNKBVpYy0",
      appId: "1:378273906681:web:f2c367bc3b2055ffaa0728",
      messagingSenderId: "378273906681",
      projectId: "a-insta-clone",
      storageBucket: "a-insta-clone.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserProvider()),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Insta Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: _auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.hasError}'));
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }
    
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
