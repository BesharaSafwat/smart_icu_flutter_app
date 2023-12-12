import 'package:flutter/material.dart';
import 'package:icu/models/usermodel.dart';
import 'package:icu/screens/authenticate/authenticate.dart';
import 'package:icu/screens/monitor/doctorview.dart';
import 'package:provider/provider.dart';

import 'monitor/nurseview.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);
    print(user);

    // return Doctor, Nurse, patient view or login view
    if (user == null){
      return Authenticate();
    }
    else if(user.email == 'ahmed@mail.com'){
      return DoctorView();
    }
    else {
      return NurseView();

    }
  }
}
