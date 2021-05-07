import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/database/repository.dart';
import 'package:medicine/models/pill.dart';
import 'package:medicine/utils/colors.dart';

class PharmTile extends StatefulWidget {
  final Pill data;
  final String createdTime;
  final bool repeat;
  final Function setData;

  PharmTile(this.data, this.setData, this.createdTime, this.repeat);

  @override
  _PharmTileState createState() => _PharmTileState();
}

class _PharmTileState extends State<PharmTile> {
  int doneAll;
  int done1;
  int done2;
  List<bool> dones = [false, true];
  final Repository _repository = Repository();

  @override
  void initState() {
    super.initState();
    //--------------------| Initialize all done variables to check whether medicine is taken or not |----------------------
    done1 = widget.data.done1;
    done2 = widget.data.name2 == '' ? 1 : widget.data.done2;
    doneAll = ((done1 + done2) == 2) ? 1 : widget.data.doneAll;
    //===================================================================
  }

  //--------------------| Circular check mark plus conditions for all dones |----------------------
  Widget CircularCkeck(int _done, int _num) {
    return InkWell(
      onTap: () {
        setState(() {
          _done = _done == 0 ? 1 : 0;
          switch (_num) {
            case 0:
              doneAll = _done;
              done1 = doneAll;
              done2 = doneAll;
              break;
            case 1:
              done1 = _done;
              doneAll = done1 + done2 == 2 ? 1 : 0;
              break;
            case 2:
              done2 = _done;
              doneAll = done1 + done2 == 2 ? 1 : 0;
              break;
          }
        });
        _repository.updateData(
            "Pills", widget.data.id, done1, done2, doneAll, widget.data.type);
      },
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dones[doneAll] ? Colors.white : Color(0xffF2F2F2),
            border: Border.all(
              color: dones[doneAll] ? Color(0xFF508690) : Colors.black54,
              width: 2,
            )),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: dones[_done]
              ? Icon(
                  Icons.check,
                  size: 20.0,
                  color: Color(0xFF508690),
                )
              : Container(),
        ),
      ),
    );
  }
  //===================================================================

  //--------------------| Capitilize the first letter |----------------------
  String capitalize(String s) => s
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((s) => s.length > 0 ? '${s[0].toUpperCase()}${s.substring(1)}' : '')
      .join(" ");
  //===================================================================

  //--------------------| Build cards for the input medicines  |----------------------
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
        child: Column(
          children: [
            Row(
              children: [
                !widget.repeat
                    ? Text(
                        capitalize((widget.createdTime)),
                        style: TextStyle(color: Colors.black54, fontSize: 24),
                      )
                    : Container(),
              ],
            ),
            Card(
              color: dones[doneAll] ? MyColors.medapp : Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
                child: ExpansionTile(
                  title: Text(
                    widget.data.type +
                        '\n ${widget.data.hour} : ${widget.data.min}',
                    // DateFormat('HH:MM').format(
                    //     DateTime.fromMicrosecondsSinceEpoch(
                    //         widget.data.time)),
                    style: TextStyle(
                        color: dones[doneAll] ? Colors.white : Colors.black,
                        fontSize: 22),
                  ),
                  trailing: CircularCkeck(doneAll, 0),
                  children: <Widget>[
                    ListTile(
                      title: Text(widget.data.name +
                          '\n' +
                          widget.data?.amount +
                          ' ' +
                          'stucks'),
                      trailing: CircularCkeck(done1, 1),
                    ),
                    widget.data.name2 != ''
                        ? ListTile(
                            title: Text(widget.data?.name2 +
                                '\n' +
                                widget.data?.amount2 +
                                ' ' +
                                'stucks'),
                            trailing: CircularCkeck(done2, 2),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ));
    //===================================================================
  }
}
