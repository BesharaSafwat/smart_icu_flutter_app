// import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icu/models/usermodel.dart';
import 'package:icu/service/auth.dart';
import 'package:icu/service/database.dart';
import 'package:provider/provider.dart';
import 'package:icu/screens/monitor/patient_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
//
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

// ESP CAM imports
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:network_info_plus/network_info_plus.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});
  final String title = 'Doctor View';
  @override
  State<StatefulWidget> createState() => DoctorViewState();
}

class DoctorViewState extends State<DoctorView> {
  RawDatagramSocket? sock;
  // int CHUNK_LENGTH = 1460;
  List<int> byteVector = [];
  Uint8List jpgData = Uint8List(0);
  bool startOfImage = false;
  bool hasNewImage = false;

  @override
  void initState() {
    super.initState();
    initSocket();
  }
  Future<void> initSocket() async {
    try {
      // sock = await RawDatagramSocket.bind(Ipify.ipv4(),8000);
      // sock = await NetworkInfo().getWifiIP();
      sock = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8000);
      print('Socket bound to ${sock!.address.address}:${sock!.port}');
    } catch (e) {
      print('Error binding socket: $e');
      return;
    }
    await for (RawSocketEvent event in sock!) {
      if (event == RawSocketEvent.read) {
        Datagram? datagram = sock!.receive();
        if (datagram != null) {
          List<int> data = datagram.data;

          if (data.length >= 3 &&
              data[0] == 255 &&
              data[1] == 216 &&
              data[2] == 255) {
            startOfImage = true;
            byteVector = List.from(data);
          } else if (startOfImage) {
            byteVector.addAll(data);

            if (data.length >= 2 &&
                data[data.length - 2] == 255 &&
                data[data.length - 1] == 217) {
              try {
                Uint8List newJpgData = Uint8List.fromList(byteVector);

                if (!Uint8ListEquality().equals(newJpgData, jpgData)) {
                  hasNewImage = true;
                  jpgData = newJpgData;
                }

                startOfImage = false;
                byteVector.clear();
              } catch (e) {
                print('Error converting to JPEG: $e');
                startOfImage = false;
                byteVector.clear();
              }
            }
            if (hasNewImage) {
              hasNewImage = false;
              setState(() {});
            }
          }
        }
      }
    }
  }
  @override
  void dispose() {
    sock?.close();
    super.dispose();
  }
  // String temp = '37' ;
  // String heart_rate = '60' ;
  // String systolic_blood_pressure = '120' ;
  // String diastolic_blood_pressure = '80' ;

  final AuthService _auth = AuthService();

  final databaseReference = FirebaseDatabase.instance.ref();
  String? uid = FirebaseAuth.instance.currentUser?.uid ;

  bool showCam = false;
  String buttonText = 'Show';
  // Future getUid() async{
  //     dynamic result = await _auth.loginEmailPass();
  // }
  // QuerySnapshot<Object?> f = QuerySnapshot<> as QuerySnapshot<Object?>;
  // QuerySnapshot<Object?> getInitialData() async{
  //   Future<QuerySnapshot<Object?>> h = await DataBaseService(uid: uid).signs.first;
  //   QuerySnapshot<Object?> g = h as QuerySnapshot<Object?> ;
  //   return g;
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   databaseref.child('ESP').once().then((DataSnapshot dataSnapshot) {
  //     // double temp = dataSnapshot.value['Temperature'];
  //     // int heart_rate = dataSnapshot.value['Heart Rate'];
  //     // int systolic_blood_pressure = dataSnapshot.value['Systolic Blood Pressure '];
  //     // int diastolic_blood_pressure = dataSnapshot.value['Diaystolic Blood Pressure '];
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    // databaseReference.child('temp').once().then((DatabaseEvent event) {
    //   DataSnapshot snapshot = event.snapshot;
    //   print('Data: ${snapshot.value}');
    //   setState(() {
    //     temp = snapshot.value.toString();
    //   });
    // });
    // return FutureBuilder(
    //     future: Firebase.initializeApp(),
    //     builder: (context,snapshot) {
    //      if(snapshot.hasError){
    //        return Center(child: Container(color: Colors.cyan,));
    //      }
    //      if(snapshot.connectionState == ConnectionState.done){
    //        return Center(child: Container(color: Colors.,));
    //      }
    //     },
    // );
    //   // StreamProvider<QuerySnapshot>.value(
    //   // value: DataBaseService(uid: uid).signs,
    //   // initialData: getInitialData(),
    //   // child:
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: const Text(
                    'Sign out'
                  ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsetsDirectional.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Temperature: ',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(width: 24),
                        StreamBuilder<String>(
                          stream: _getDataStream('temp'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!
                                ,overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.displaySmall,);
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displaySmall,);
                            } else {
                              return Text('Loading...',overflow: TextOverflow.ellipsis ,style: Theme.of(context).textTheme.displaySmall,);
                            }
                          },
                        ),
                     ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          'Heart Rate: ',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(width: 24),
                        StreamBuilder<String>(
                          stream: _getDataStream('heart_rate'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!
                                , overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.displaySmall,);
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displaySmall,);
                            } else {
                              return Text('Loading...', style: Theme.of(context).textTheme.displaySmall,);
                            }
                          },
                        ),
                     ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                'Blood Pressure: ',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(width: 24),
                              StreamBuilder<String>(
                                stream: _getDataStream('systolic_bp'),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!
                                      ,overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.displaySmall,);
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displaySmall,);
                                  } else {
                                    return Text('Loading...', overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.displaySmall,);
                                  }
                                },
                              ),
                              Text(
                                '/',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              StreamBuilder<String>(
                                stream: _getDataStream('diastolic_bp'),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!
                                      ,overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.displaySmall,);
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displaySmall,);
                                  } else {
                                    return Text('Loading...',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displaySmall,);
                                  }
                                },
                              ),
                              // Text(
                              //   '$systolic_blood_pressure / $diastolic_blood_pressure',
                              //   style: Theme.of(context).textTheme.displaySmall,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          'ECG: ',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(width: 24),
                        StreamBuilder<String>(
                          stream: _getDataStream('prediction_values'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!
                                , overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.displaySmall,);
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displaySmall,);
                            } else {
                              return Text('Loading...', style: Theme.of(context).textTheme.displaySmall,);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Column(
                  children: [
                    (showCam)?
                    // showCam?
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color:  Colors.blue,
                      ),
                      child: Image.memory(
                        jpgData,
                        gaplessPlayback: true,
                        width: double.infinity,
                        height: 400,
                      ),
                    ) : Container(),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              await setValueToFirebase('/button',showCam);
                              setState(() {
                                showCam = !showCam;
                                if(showCam){
                                  buttonText = 'Hide';
                                }
                                else{
                                  buttonText = 'Show';
                                }
                              });
                            },
                            child: Text(buttonText)
                        ),
                      ],
                    ),
                  ],
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       captureData('temp');
                //     },
                //     child: Text(
                //       'Update Temp'
                //     )
                // ),
              ],
            ),
          ),
        ),
    );
  }
  Stream<String> _getDataStream(req_data) {
    // final  root = FirebaseDatabase.instance.ref().root;
    final databaseReference = FirebaseDatabase.instance.ref().child(req_data);
    return databaseReference.onValue.map((event) => event.snapshot.value.toString());
  }
  Future<void> setValueToFirebase(String path, dynamic value) async {

    try {
      final databaseReference = FirebaseDatabase.instance.ref(path);
      await databaseReference.set(value);
      print('Data successfully written to $path!');
    } catch (error) {
      print('Error setting data to $path: $error');
    }
  }

  // Future<InternetAddress> get selfIP async {
  //   String ip = await Wifi.ip;
  //   return InternetAddress(ip);
  // }
  Future getIP() async{
    String ipv4 = await Ipify.ipv4();
    return ipv4 ;
  }
// void captureData(data) {
  //   databaseReference.child(data).once().then((DatabaseEvent event) {
  //     DataSnapshot snapshot = event.snapshot;
  //     print('Data: ${snapshot.value}');
  //     setState(() {
  //       temp = snapshot.value.toString();
  //     });
  //   });
  // }
}

class Uint8ListEquality {
  bool equals(Uint8List list1, Uint8List list2) {
    if (list1.length != list2.length) {
      return false;
    }
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }
}

