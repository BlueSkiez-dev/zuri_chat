// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:zuri_chat_01/components/rounded_button.dart';
// import 'package:zuri_chat_01/constants.dart';
// import 'package:zuri_chat_01/screens/login_screen.dart';

// import 'chat_screen.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

// class RegistrationScreen extends StatefulWidget {
//   static const String id = 'registration_screen';
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _auth = FirebaseAuth.instance;
//   bool showSpinner = false;
//   String email;
//   String password;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: ModalProgressHUD(
//           color: kSecondaryColor,
//           inAsyncCall: showSpinner,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Container(
//                     decoration: BoxDecoration(
//                         color: kPrimaryColor,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Row(
//                             children: [
//                               IconButton(
//                                   icon: Icon(Icons.arrow_back_ios),
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   }),
//                               SizedBox(width: 50),
//                               Text(
//                                 'Sign Up',
//                                 style: TextStyle(
//                                     fontSize: 25, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: SvgPicture.asset(
//                             "assets/images/signin.svg",
//                             fit: BoxFit.contain,
//                             width: 160,
//                             height: 160,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 48.0,
//                   ),
//                   TextFormField(
//                     textInputAction: TextInputAction.next,
//                     cursorColor: kSecondaryColor,
//                     keyboardType: TextInputType.emailAddress,
//                     textAlign: TextAlign.center,
//                     onChanged: (value) {
//                       email = value;
//                     },
//                     decoration: kTextFieldDecoration.copyWith(
//                         hintText: 'Enter your email'),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   TextField(
//                     cursorColor: kSecondaryColor,
//                     obscureText: true,
//                     textAlign: TextAlign.center,
//                     onChanged: (value) {
//                       password = value;
//                     },
//                     decoration: kTextFieldDecoration.copyWith(
//                         hintText: 'Enter your password'),
//                   ),
//                   SizedBox(
//                     height: 3.0,
//                   ),
//                   RoundedButton(
//                     title: 'Sign Up',
//                     colour: kSecondaryColor,
//                     color2: Colors.white,
//                     onPressed: () async {
//                       setState(() {
//                         showSpinner = true;
//                       });
//                       try {
//                         final newUser =
//                             await _auth.createUserWithEmailAndPassword(
//                                 email: email, password: password);
//                         if (newUser != null) {
//                           Navigator.pushNamed(context, ChatScreen.id);
//                         }

//                         setState(() {
//                           showSpinner = false;
//                         });
//                       } catch (e) {
//                         print(e);
//                       }
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Already a member?',
//                       ),
//                       SizedBox(width: 3),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, LoginScreen.id);
//                         },
//                         child: Text(
//                           'Sign In',
//                           style: TextStyle(color: kSecondaryColor),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
