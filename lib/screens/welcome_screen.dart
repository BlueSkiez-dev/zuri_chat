import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zuri_chat/components/rounded_button.dart';
import 'package:zuri_chat/constants.dart';
import 'package:zuri_chat/screens/chat_screen.dart';
import 'package:zuri_chat/screens/home.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool pageInitialised = false;

  final googleSignIn = GoogleSignIn();

  final firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    checkIfUserLoggedIn();
    super.initState();
  }

  checkIfUserLoggedIn() async {
//    await googleSignIn.signOut();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    sharedPreferences.setString("id", '');
    bool userLoggedIn = (sharedPreferences.getString('id') ?? '').isNotEmpty;

    if (userLoggedIn) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ChatScreen()));
    } else {
      setState(() {
        pageInitialised = true;
      });
    }
  }

  handleSignIn() async {
    final res = await googleSignIn.signIn();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final auth = await res.authentication;

    final credentials = GoogleAuthProvider.credential(
        idToken: auth.idToken, accessToken: auth.accessToken);

    final firebaseUser =
        (await firebaseAuth.signInWithCredential(credentials)).user;

    if (firebaseUser != null) {
      final result = (await FirebaseFirestore.instance
              .collection('users')
              .where('id', isEqualTo: firebaseUser.uid)
              .get())
          .docs;

      if (result.length == 0) {
        ///new user

        FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set({
          "id": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "profile_pic": firebaseUser.photoURL,
          "created_at": DateTime.now().millisecondsSinceEpoch,
        });

        sharedPreferences.setString("id", firebaseUser.uid);
        sharedPreferences.setString("name", firebaseUser.displayName);
        sharedPreferences.setString("profile_pic", firebaseUser.photoURL);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatScreen()));
      } else {
        ///Old user

        sharedPreferences.setString("id", result[0]["id"]);
        sharedPreferences.setString("name", result[0]["name"]);
        sharedPreferences.setString("profile_pic", result[0]["profile_pic"]);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (pageInitialised)
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Zuri Chat.',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                              "assets/images/medi.svg",
                              fit: BoxFit.contain,
                              width: 180,
                              height: 180,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        children: [
                          RoundedButton(
                            title: 'Sign in with Google',
                            colour: kSecondaryColor,
                            color2: Colors.white,
                            onPressed: handleSignIn,
                          ),
                          // RoundedButton(
                          //   title: 'Sign In',
                          //   colour: kPrimaryColor,
                          //   color2: Colors.black,
                          //   onPressed: () {
                          //     Navigator.pushNamed(context, LoginScreen.id);
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                  ),
                ),
              ),
      ),
    );
  }
}
