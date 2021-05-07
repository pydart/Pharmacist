import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine/models/pill.dart';
import 'package:medicine/screens/home/pharm_tile.dart';
import 'package:intl/date_symbol_data_local.dart';

class MedicinesList extends StatelessWidget {
  final List<Pill> listOfMedicines;
  final Function setData;

  MedicinesList(this.listOfMedicines, this.setData);

  @override
  Widget build(BuildContext context) {
    String previousTime = '';
    bool repeat = false;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        listOfMedicines.sort((a, b) => a.time.compareTo(b.time));
        final data = listOfMedicines[index];
        String createdTime = _getDate(data?.time);
        repeat = previousTime == createdTime ? true : false;
        previousTime = createdTime;
        return PharmTile(data, setData, createdTime, repeat);
      },
      itemCount: listOfMedicines.length,
      shrinkWrap: true,
    );
  }

  String _getDate(int time) {
    if (time == null) return '';
    initializeDateFormatting('nl', null);
    var format = DateFormat('EEEE d MMM', 'nl');
    var dateString = format.format(DateTime.fromMillisecondsSinceEpoch(time));
    return dateString;
  }
}
