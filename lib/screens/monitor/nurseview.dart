import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../service/auth.dart';

class NurseView extends StatefulWidget {
  const NurseView({super.key});

  final String title = 'Nurse View';

  @override
  State< NurseView> createState() => _NurseViewState();
}

class _NurseViewState extends State<NurseView> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
                            return Text(snapshot.data!,overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.displaySmall,);
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
                      Text(
                        'Heart Rate: ',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(width: 24),
                      StreamBuilder<String>(
                        stream: _getDataStream('heart_rate'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!, overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.displaySmall,);
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
                      Expanded(
                        child: SingleChildScrollView(
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
                                    return Text(snapshot.data!,overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.displaySmall,);
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displaySmall,);
                                  } else {
                                    return Text('Loading...', style: Theme.of(context).textTheme.displaySmall,);
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
                                    return Text(snapshot.data!,overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.displaySmall,);
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displaySmall,);
                                  } else {
                                    return Text('Loading...', style: Theme.of(context).textTheme.displaySmall,);
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
                      ),
                    ],
                  ),
                ],
              ),
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

}
