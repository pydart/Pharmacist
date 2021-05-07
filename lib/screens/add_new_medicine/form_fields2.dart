import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFields2 extends StatelessWidget {
  final TextEditingController nameController2;
  final TextEditingController amountController2;
  FormFields2(this.nameController2, this.amountController2);

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: constrains.maxHeight * 0.07,
          ),
          Container(
            height: constrains.maxHeight * 0.22,
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: nameController2,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  labelText: "Pills Name 2",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 0.5, color: Colors.grey))),
              onSubmitted: (val) => focus.nextFocus(),
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.07,
          ),
          Container(
            height: constrains.maxHeight * 0.22,
            child: TextField(
              controller: amountController2,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  labelText: "Pills Amount 2",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 0.5, color: Colors.grey))),
              onSubmitted: (val) => focus.unfocus(),
            ),
          ),
        ],
      ),
    );
  }
}
