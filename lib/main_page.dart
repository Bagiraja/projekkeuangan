import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projekuang/category_page.dart';
import 'package:projekuang/home_page.dart';
import 'package:projekuang/models/database.dart';
import 'package:projekuang/transaction_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DateTime selectedDate;
  final database = AppDb();
  late List<Widget> _children;
  late int currentIndex;


  @override
  void initState() {
    // TODO: implement initState
    updateView(0, DateTime.now());
    super.initState();
  }

  

 void updateView(int index, DateTime? date) {
  setState(() {
    if (date != null) {
      selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
 }
   currentIndex  = index;
   _children =[HomePage(selectedDate: selectedDate),  Categorypage()
   ];
  });
 }
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              accent: Colors.blueAccent,
              backButton: false,
              locale: 'id',
              onDateChanged: (value) {
               setState(() {
                selectedDate = value;
                updateView(0, selectedDate);
               });
             },
              firstDate: DateTime.now().subtract(Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : PreferredSize(
              child: Container(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                child: Text('categories', style: TextStyle(fontSize: 25)),
              )),
              preferredSize: Size.fromHeight(100)),
      floatingActionButton: Visibility(
        visible: (currentIndex == 0) ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) => TransactionPage(transactionWithCategory: null,),)).then((value){
                setState(() {
                });
              }
              
              );
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
        ),
      ),
      body: _children[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(
            onPressed: () {
              updateView(0, DateTime.now());
            },
            icon: Icon(Icons.home)),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
             updateView(1, null);
            },
            icon: Icon(Icons.list))
      ])),
    );
  }
}
