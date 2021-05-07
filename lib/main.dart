import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/screens/add_new_medicine/add_new_medicine.dart';
import 'package:medicine/screens/home/home_page.dart';
import 'package:medicine/utils/colors.dart';

void main() {
  runApp(MedicineApp());
}

class MedicineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Popins",
        primaryColor: MyColors.medapp,
      ),
      routes: {
        "/home": (context) => Home(),
        "/add_new_medicine": (context) => AddNewMedicine(),
      },
      initialRoute: "/home",
    );
  }
}
