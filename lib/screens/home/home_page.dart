import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/utils/colors.dart';
import '../../database/repository.dart';
import '../../models/pill.dart';
import '../../screens/home/medicines_list.dart';
import 'home_week.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  PageController pageController;
  DateTime setDate = DateTime.now();

  //--------------------| The bottom bar when is tapped, there is a smooth movement of the change to the new icon |----------------------
  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
  //=========================================================================

  //--------------------| The bottom bar when is tapped, new value is put in pageIndex |----------------------
  onPageChanged(int pageIndex) {
    if (!mounted) return;
    setState(() {
      this.pageIndex = pageIndex;
    });
  }
  //=========================================================================

  //--------------------| List of Pills from database |----------------------
  List<Pill> allListOfPills = [];
  final Repository _repository = Repository();
  List<Pill> dailyPills = [];
  //=========================================================================

  @override
  void initState() {
    super.initState();
    //-----------------| Our initial page is index 0 |------------------
    pageController = PageController(initialPage: 0);
    //-----------------| get the list of saved medicines |------------------
    setData();
  }

  //-----------------| Make the header of the page with changing subtitle for each page index|------------------

  Container _buildHeader(BuildContext context) {
    return Container(
      color: MyColors.medapp,
      padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
      width: double.infinity,
      height: 140,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Spacer(),
                  Row(
                    children: <Widget>[
                      // Icon(
                      //   Icons.schedule,
                      //   color: Colors.white,
                      // ),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      Text(
                        'Pharmacist',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _getSubtitleHeader()),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Image.asset(
                  "assets/images/1.png",
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }
  //====================================================

  //-----------------| Subtitle used in the header changes in each tab |------------------
  Widget _getSubtitleHeader() {
    switch (pageIndex) {
      case 0:
        return _buildSubtitleHeader('All scheduled days!');
      case 1:
        return _buildSubtitleHeader('All for one week');
    }
    return Container();
  }

  Widget _buildSubtitleHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }
  //===================================================================

  //--------------------GET ALL DATA FROM DATABASE---------------------
  Future setData() async {
    allListOfPills.clear();
    (await _repository.getAllData("Pills")).forEach((pillMap) {
      allListOfPills.add(Pill().pillMapToObject(pillMap));
    });
    chooseDay(setDate);
  }
  //===================================================================

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    //--------------------A Floating button to make new Pills---------------------
    final Widget addButton = FloatingActionButton(
      elevation: 2.0,
      onPressed: () async {
        await Navigator.pushNamed(context, "/add_new_medicine")
            .then((_) => setData());
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 24.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
    //===================================================================

    //--------------------Building scaffold of the page---------------------
    return Scaffold(
      floatingActionButton: addButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: Container(
        child: Column(
          children: <Widget>[
            _buildHeader(context),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[_buildListScreen()],
              ),
            ),
            Container()
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: MyColors.medapp,
        backgroundColor: Colors.white54,
        height: 50,
        items: <Widget>[
          Icon(
            Icons.local_pharmacy,
            color: Colors.white,
          ),
          Icon(
            Icons.view_week,
            color: Colors.white,
          ),
        ],
        index: pageIndex,
        onTap: onTap,
      ),
    );
  }
  //===================================================================

  //--------------------To build Screens ---------------------
  _buildListScreen() {
    return Scaffold(
        body: PageView(
      children: <Widget>[
        allListOfPills.isEmpty
            ? SizedBox(
                width: double.infinity,
                height: 100,
                child: WavyAnimatedTextKit(
                  textStyle: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  text: [" No data..."],
                  isRepeatingAnimation: false,
                  speed: Duration(milliseconds: 150),
                ),
              )
            : MedicinesList(allListOfPills, setData),
        HomeWeek(),
      ],
      controller: pageController,
      onPageChanged: onPageChanged,
      // physics: NeverScrollableScrollPhysics(),
    ));
  }
  //===================================================================

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
