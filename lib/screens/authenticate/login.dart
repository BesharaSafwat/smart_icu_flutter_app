// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:icu/service/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{

  final AuthService _auth = AuthService();

  // String email = '4';
  // String password = '5';
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey();

    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: email,
                            onChanged: (val) {
                              // setState(() => email = val);
                              // print('email is'+ email.text);
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            obscureText: true,
                            controller: password,
                            onChanged: (val) {
                              // print('password is'+ password.text);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Container(
                        width:double.infinity,
                        height: 64,
                        child: ElevatedButton(
                            onPressed: () async
                            {
                              print('email is '+ email.text);
                              print('email is '+ password.text);

                             dynamic result = await _auth.loginEmailPass(email.text,password.text);
                             if(result == null){
                               print('error Signing in ');
                             }
                             else{
                                print('Signed in ');
                                print(result.uid);
                             }

                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.brown[600]),
                            ),
                            child:
                            Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                                   )
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        ) ,
      ),
    );
  }

}
//
// // import 'package:chat_app/widgets/custom_elevated_button.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// // import 'package:chat_app/color_schemes.g.dart'; // Import your color scheme
// // import 'signup_Page.dart';
// // import 'package:chat_app/screens/Navigation_Bar.dart'; // Import MyNavigationBar class
// // import 'package:chat_app/core/constants/constant_variables.dart';
// // import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:chat_app/widgets/custom_text_field.dart';
// // import 'package:chat_app/widgets/custom_button.dart';
// // import 'package:chat_app/widgets/custom_image_view.dart';
// // import 'package:chat_app/core/Utils/size_responsive.dart';
//
// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});
//   static String id = 'Log in';
//
//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }
//
// class _SignInPageState extends State<SignInPage> {
//   String? email;
//   String? password;
//   GlobalKey<FormState> formkey = GlobalKey();
//   bool isloading = false;
//   // TextEditingController emailController = TextEditingController();
//
//   // TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     var mediaQueryData = MediaQuery.of(context);
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 37, 51,
//           52), // Set the background color to match the color scheme
//       body: ModalProgressHUD(
//         inAsyncCall: isloading,
//         child: Form(
//           key: formkey,
//           child: SizedBox(
//             height: mediaQueryData.size.height,
//             width: double.maxFinite,
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: 27.h,
//                       top: 101.v,
//                       right: 27.h,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CustomImageView(
//                           imagePath: './assets/images/logo.png',
//                           height: 49.v,
//                           width: 43.h,
//                           margin: EdgeInsets.only(left: 8.h),
//                         ),
//                         SizedBox(height: 34.v),
//                         Padding(
//                           padding: EdgeInsets.only(left: 8.h),
//                           child: Text(
//                             "Sign In",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 fontSize: 27,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 299.h,
//                             margin: EdgeInsets.only(
//                               left: 8.h,
//                               right: 13.h,
//                             ),
//                             child: Text(
//                               "Sign in now to acces your profile",
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(color: const Color.fromARGB(129, 255, 255, 255)),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 52.v),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: 8.h,
//                             right: 7.h,
//                           ),
//                           child: Custom_text_field(
//                             onchange: (data) {
//                               email = data;
//                             },
//                             // controller: emailController,
//                             hinttext: 'email address',
//                             textInputType: TextInputType.emailAddress,
//                             contentPadding:
//                             EdgeInsets.symmetric(horizontal: 10.h),
//                           ),
//                         ),
//                         SizedBox(height: 37.v),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: 8.h,
//                             right: 7.h,
//                           ),
//                           child: Custom_text_field(
//                             // controller: passwordController,
//                             onchange: (data) {
//                               password = data;
//                             },
//                             hinttext: "password",
//                             textInputAction: TextInputAction.done,
//                             textInputType: TextInputType.visiblePassword,
//                             // obscureText: true,
//                             contentPadding:
//                             EdgeInsets.symmetric(horizontal: 10.h),
//                           ),
//                         ),
//                         SizedBox(height: 8.v),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: EdgeInsets.only(right: 7.h),
//                             child: Text(
//                               "forgot password?",
//                               style: TextStyle(color: const Color.fromARGB(144, 255, 255, 255)),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 28.v),
//                         CustomElevatedButton(
//                           buttonTextStyle: TextStyle(
//                               color: const Color.fromARGB(251, 255, 255, 255)),
//                           onPressed: () async {
//                             if (formkey.currentState!.validate()) {
//                               isloading = true;
//                               setState(() {});
//                               try {
//                                 await userLogin();
//                                 // showMessage(context, 'Success');
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                       const MyNavigationBar()),
//                                 );
//                               } on FirebaseAuthException catch (e) {
//                                 if (e.code == 'user-not-found') {
//                                   showMessage(
//                                       context, 'This user is not found');
//                                   print('1');
//                                 } else if (e.code == 'wrong-password') {
//                                   showMessage(context, 'Wrong Password');
//                                   print('2');
//                                 }
//                               } catch (e) {
//                                 print(e);
//                               }
//                               isloading = false;
//                               setState(() {});
//                             } else {}
//                           },
//                           text: "LOG IN",
//                         ),
//                         SizedBox(height: 20.v),
//                         Align(
//                           alignment: Alignment.center,
//                           child: RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: "don_t have an account?",
//                                   style: TextStyle(color: const Color.fromARGB(103, 255, 255, 255)),
//                                 ),
//                                 TextSpan(
//                                   text: "  ",
//                                 ),
//                                 TextSpan(
//                                   text: "Sign Up",
//                                   style: TextStyle(color: const Color.fromARGB(188, 255, 255, 255)),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       Navigator.pushNamed(context, 'up');
//                                     },
//                                 ),
//                               ],
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Opacity(
//                   opacity: 0.3,
//                   child: Image(
//                     image: AssetImage('./assets/images/img_Group_28.png'),
//                     height: 150,
//                     width: 375,
//                     alignment: Alignment.bottomCenter,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

  // void showMessage(BuildContext context, String warningtext) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(warningtext),
  //     ),
  //   );
  // }
  //
  // Future<void> userLogin() async {
  //   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: email!,
  //     password: password!,
  //   );
  // }
// }

// ListView(
//             children: [
//               SizedBox(
//                 height: 75,
//               ),
//               Image.asset(
//                 'assets/images/scholar.png',
//                 height: 100,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Hello, Welcome ',
//                     style: TextStyle(
//                       fontSize: 32,
//                       color: lightColorScheme.inverseSurface,
//                       fontWeight: FontWeight.bold,

//                       // Use the color scheme
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 75,
//               ),
//               // Row(
//               //   children: [
//               //     Text(
//               //       'LOGIN',
//               //       style: TextStyle(
//               //         fontSize: 24,
//               //         color: darkColorScheme.secondaryContainer,  // Use the color scheme
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Custom_text(

//                 onchange: (data) {
//                   email = data;
//                 },
//                 hinttext: 'Email',

//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Custom_text(
//                 onchange: (data) {
//                   password = data;
//                 },
//                 hinttext: 'Password',

//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Custom_Button(
//                 onTap: () async {
//                   if (formkey.currentState!.validate()) {
//                     isloading = true;
//                     setState(() {});
//                     try {
//                       await userLogin();
//                       showMessage(context, 'Success');
//                       // Navigator.pushNamed(context, 'profile');
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const MyNavigationBar()),
//                       );
//                     } on FirebaseAuthException catch (e) {
//                       if (e.code == 'user-not-found') {
//                         showMessage(context, 'This user is not found');
//                       } else if (e.code == 'wrong-password') {
//                         showMessage(context, 'Wrong Password');
//                       }
//                     } catch (e) {
//                       print(e);
//                     }
//                     isloading = false;
//                     setState(() {});
//                   } else {}
//                 },
//                 text: 'LOGIN',
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'don\'t have an account?',
//                     style: TextStyle(
//                       color: lightColorScheme.tertiary,  // Use the color scheme
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, 'up');
//                     },
//                     child: Text('Sign Up'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
