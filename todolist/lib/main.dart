import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/pages/add_event_page.dart';
import 'package:todolist/pages/add_task_page.dart';
import 'package:todolist/pages/event_page.dart';
import 'package:todolist/pages/task_page.dart';
import 'package:todolist/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import 'models/database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Database>(builder: (_) => Database())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo list',
        theme: ThemeData(primarySwatch: Colors.red, fontFamily: "UTM Avo"),
        home: MyHomePage(),
      ),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHomePage> {
  PageController _pageController = PageController();
  double currentPage = 0;
  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });

    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    String _dayNow = formatter.format(now);

    return Scaffold(
      appBar: null,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Theme.of(context).accentColor,
              height: 35,
            ),
            Positioned(
                right: 0,
                child: Text(
                  _dayNow,
                  style: TextStyle(fontSize: 200, color: Color(0x10000000)),
                )),
            _mainContent(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    child: currentPage == 1 ? AddEventPage() : AddTaskPage(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))));
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
      ),
    );
  }

  Column _mainContent(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('E');
    String _dayOfWeek = formatter.format(now);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _dayOfWeek,
            style: TextStyle(
                color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24,5,24,5),
          child: _buttonTop(context),
        ),
        Expanded(
            child: PageView(
                controller: _pageController,
                children: <Widget>[TaskPage(), EventPage()])),
      ],
    );
  }

  Row _buttonTop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
            child: CustomBotton(
          onPressed: () {
            _pageController.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
          },
          buttonText: 'Ghi chú',
          textColor:
              currentPage < 0.5 ? Colors.white : Theme.of(context).accentColor,
          color:
              currentPage < 0.5 ? Theme.of(context).accentColor : Colors.white,
          borderColor: currentPage < 0.5
              ? Colors.transparent
              : Theme.of(context).accentColor,
        )),
        SizedBox(
          width: 32,
        ),
        Expanded(
            child: CustomBotton(
          onPressed: () {
            _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
          },
          buttonText: 'Sự kiện',
          textColor:
              currentPage > 0.5 ? Colors.white : Theme.of(context).accentColor,
          color:
              currentPage > 0.5 ? Theme.of(context).accentColor : Colors.white,
          borderColor: currentPage > 0.5
              ? Colors.transparent
              : Theme.of(context).accentColor,
        )),
      ],
    );
  }
}
