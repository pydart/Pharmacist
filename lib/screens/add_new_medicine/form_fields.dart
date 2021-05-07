import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  final List<String> weightValues = ["Home", "Werk", "Lunch"];
  final int howManyWeeks;
  final String selectWeight;
  final Function onPopUpMenuChanged, onSliderChanged;
  final TextEditingController nameController;
  final TextEditingController amountController;
  FormFields(this.howManyWeeks, this.selectWeight, this.onPopUpMenuChanged,
      this.onSliderChanged, this.nameController, this.amountController);

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: constrains.maxHeight * 0.22,
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: nameController,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  labelText: "Pills Name (required)",
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
              controller: amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  labelText: "Pills Amount (required)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 0.5, color: Colors.grey))),
              onSubmitted: (val) => focus.unfocus(),
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.07,
          ),
          Container(
            height: constrains.maxHeight * 0.32,
            child: DropdownButtonFormField(
              onTap: () => focus.unfocus(),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  labelText: "Type (required)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 0.5, color: Colors.grey))),
              items: weightValues
                  .map((weight) => DropdownMenuItem(
                        child: Text(weight),
                        value: weight,
                      ))
                  .toList(),
              onChanged: (value) => this.onPopUpMenuChanged(value),
              value: selectWeight,
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.1,
          ),
        ],
      ),
    );
  }
}
