class Pill {
  int id;
  String name;
  int done1;
  int done2;
  int doneAll;
  String name2;
  String amount;
  String amount2;
  String type;
  int howManyWeeks;
  String medicineForm;
  int time;
  int notifyId;
  int hour;
  int min;

  Pill(
      {this.id,
      this.howManyWeeks,
      this.time,
      this.hour,
      this.min,
      this.amount,
      this.amount2,
      this.medicineForm,
      this.name,
      this.name2,
      this.done1,
      this.done2,
      this.doneAll,
      this.type,
      this.notifyId});

  //------------------set pill to map-------------------

  Map<String, dynamic> pillToMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['name'] = this.name;
    map['name2'] = this.name2;
    map['done1'] = this.done1;
    map['done2'] = this.done2;
    map['doneAll'] = this.doneAll;
    map['amount'] = this.amount;
    map['amount2'] = this.amount2;
    map['hour'] = this.hour;
    map['min'] = this.min;
    map['type'] = this.type;
    map['howManyWeeks'] = this.howManyWeeks;
    map['medicineForm'] = this.medicineForm;
    map['time'] = this.time;
    map['notifyId'] = this.notifyId;
    return map;
  }

  //=====================================================

  //---------------------create pill object from map---------------------
  Pill pillMapToObject(Map<String, dynamic> pillMap) {
    return Pill(
        id: pillMap['id'],
        name: pillMap['name'],
        name2: pillMap['name2'],
        done1: pillMap['done1'],
        done2: pillMap['done2'],
        doneAll: pillMap['doneAll'],
        amount: pillMap['amount'],
        amount2: pillMap['amount2'],
        type: pillMap['type'],
        howManyWeeks: pillMap['howManyWeeks'],
        medicineForm: pillMap['medicineForm'],
        time: pillMap['time'],
        hour: pillMap['hour'],
        min: pillMap['min'],
        notifyId: pillMap['notifyId']);
  }
}
