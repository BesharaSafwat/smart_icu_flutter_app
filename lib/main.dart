import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icu/screens/authenticate/authenticate.dart';
import 'package:icu/screens/monitor/doctorview.dart';
import 'package:icu/screens/authenticate/login.dart';
import 'package:icu/screens/wrapper.dart';
import 'package:icu/service/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/usermodel.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
    // WEB FIREBASE OPTIONS
    // -----------------------
    // options: FirebaseOptions(
    //   apiKey: 'AIzaSyCEvTraVWx7tNeCiUS8_PovxRlRIPS12b4',
    //   appId: '1:305757418974:android:83cc1859795108167e194f',
    //   messagingSenderId: '305757418974',
    //   projectId: 'icu-app1',
    //   databaseURL: 'https://icu-app1-default-rtdb.firebaseio.com',
    //   storageBucket: 'icu-app1.appspot.com',
    // )
    // MOBILE FIREBASE OPTIONS
    // -----------------------
    // options: FirebaseOptions(
    //   apiKey: 'AIzaSyDRZOFc8Iq55DefHB1gmQD05N5FkNFZkSI',
    //   appId: '1:305757418974:web:f24b2e40c07c01f67e194f',
    //   messagingSenderId: '305757418974',
    //   projectId: 'icu-app1',
    //   databaseURL: 'https://icu-app1-default-rtdb.firebaseio.com/',
    //   authDomain: 'icu-app1.firebaseapp.com',
    //   storageBucket: 'icu-app1.appspot.com',
    //   measurementId: 'G-41C214KJ6D',
    // )
  );
  // setupDependencies();
  // DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'ICU App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
          useMaterial3: true,
        ),
        home: Wrapper(),
      ),
    );
  }
}
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         'auth': (context) => Authenticate(),
//       },
//       initialRoute: 'auth',
//     );
//   }
// }
