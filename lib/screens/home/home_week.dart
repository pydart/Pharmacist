import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine/helpers/platform_flat_button.dart';
import '../../database/repository.dart';
import '../../models/pill.dart';
import '../../screens/home/medicines_list.dart';

class HomeWeek extends StatefulWidget {
  @override
  _HomeWeekState createState() => _HomeWeekState();
}

class _HomeWeekState extends State<HomeWeek> {
  DateTime setDate = DateTime.now();

  //--------------------| List of Pills from database |----------------------
  List<Pill> allListOfPills = [];
  final Repository _repository = Repository();
  List<Pill> dailyPills = [];
  //=========================================================================

  @override
  void initState() {
    super.initState();
    //-----------------| get the list of saved medicines |------------------
    setData();
  }

  //--------------------GET ALL DATA FROM DATABASE---------------------
  Future setData() async {
    allListOfPills.clear();
    (await _repository.getAllData("Pills")).forEach((pillMap) {
      allListOfPills.add(Pill().pillMapToObject(pillMap));
    });
    chooseDay(setDate);
  }
  //===================================================================

  //-------------------------SHOW DATE PICKER AND CHANGE CURRENT CHOOSE DATE-------------------------------
  Future<void> openDatePicker() async {
    await showDatePicker(
            context: context,
            initialDate: setDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : setDate.year,
          value != null ? value.month : setDate.month,
          value != null ? value.day : setDate.day,
          setDate.hour,
          setDate.minute);

      setState(() => setDate = newDate);
      chooseDay(setDate);

      print(setDate.day);
      print(setDate.month);
      print(setDate.year);
    });
  }
  //=======================================================================================================

  //--------------------Building scaffold of the second page---------------------
  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
              child: PlatformFlatButton(
                handler: () => openDatePicker(),
                buttonChild: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      DateFormat("dd.MM").format(this.setDate),
                      style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.event,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
                color: Color.fromRGBO(7, 190, 200, 0.1),
              ),
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SizedBox(height: deviceHeight * 0.03),
                  dailyPills.isEmpty
                      ? SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: WavyAnimatedTextKit(
                            textStyle: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            text: ["No data..."],
                            isRepeatingAnimation: false,
                            speed: Duration(milliseconds: 150),
                          ),
                        )
                      : MedicinesList(dailyPills, setData)
                ],
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
  //=======================================================================================================

  //-------------------------| Click on the calendar day |-------------------------
  void chooseDay(DateTime clickedDay) {
    setState(() {
      // Find the first date of the week which contains the provided date.
      DateTime FDW =
          clickedDay.subtract(Duration(days: clickedDay.weekday - 1));
      //Find last date of the week which contains provided date.
      DateTime LDW = clickedDay
          .add(Duration(days: DateTime.daysPerWeek - clickedDay.weekday));

      dailyPills.clear();
      allListOfPills.forEach((pill) {
        DateTime pillDate =
            DateTime.fromMicrosecondsSinceEpoch(pill.time * 1000);
        print(" $pillDate");

        if (FDW.day <= pillDate.day &&
            pillDate.day <= LDW.day &&
            clickedDay.month == pillDate.month &&
            clickedDay.year == pillDate.year) {
          dailyPills.add(pill);
          print("           dailyPills.add(pill); +   $dailyPills");
        }
      });
      dailyPills.sort((pill1, pill2) => pill1.time.compareTo(pill2.time));
    });
  }

//===============================================================================

}
