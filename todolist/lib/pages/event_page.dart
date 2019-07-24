import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/database.dart';
import 'package:todolist/models/todolist.dart';
import 'package:todolist/widgets/custom_icon_decoration.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Database provider;
  double iconSize = 20;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Database>(context);
    return StreamProvider.value(
        value: provider.getTodoByType(TodoType.TYPE_EVENT.index),
        child: Consumer<List<TodoData>>(builder: (context, _dataList, child) {
          return _dataList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return _itemEvent(
                        24, index, _dataList.length, _dataList[index]);
                  },
                );
        }));
  }

  Widget _itemEvent(double iconSize, int index, int listLenght, TodoData data) {
    var formatter = new DateFormat('H:m');
    String formatted = formatter.format(data.time);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Row(
        children: <Widget>[
          _lineStyle(iconSize, index, listLenght, data.isFinish, context),
          _displayTime(formatted),
          _displayContent(data)
        ],
      ),
    );
  }

  Expanded _displayContent(TodoData event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
        child: Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.task),
              SizedBox(
                height: 12,
              ),
              Text(
                event.description,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _lineStyle(double iconSize, int index, int listLenght,
      bool isFinish, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: CustomIconDecoration(
          iconSize: iconSize,
          lineWidth: 1,
          firstData: index == 0 ?? true,
          lastData: index == listLenght - 1 ?? false),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 3), color: Color(0x20000000), blurRadius: 5)
            ]),
        child: Icon(
          isFinish ? Icons.radio_button_unchecked : Icons.fiber_manual_record,
          size: 20,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Container _displayTime(String time) {
    return Container(
        width: 70,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(time),
        ));
  }
}
