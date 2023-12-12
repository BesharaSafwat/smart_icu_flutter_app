import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {

  final String? uid;
  DataBaseService({required this.uid});

  final CollectionReference vitalSignsCollection = FirebaseFirestore.instance.collection('signs');

  Future updateData(
      double temp,
      int heart_rate,
      int systolic_blood_pressure,
      int diastolic_blood_pressure ,
  ) async {
    return await vitalSignsCollection.doc(uid).set({
      'temp': temp,
      'heart rate': heart_rate,
      'systolic blood pressure': systolic_blood_pressure,
      'diastolic bllod pressure': diastolic_blood_pressure,
    });
  }

  Stream<QuerySnapshot> get signs {
    return vitalSignsCollection.snapshots();
  }
}
