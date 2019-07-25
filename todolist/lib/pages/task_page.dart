import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/database.dart';
import 'package:todolist/models/todolist.dart';
import 'package:todolist/widgets/custom_button.dart';
import 'package:todolist/widgets/custom_date_time_picker.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Database provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Database>(context);
    return StreamProvider.value(
        value: provider.getTodoByType(TodoType.TYPE_TASK.index),
        child: Consumer<List<TodoData>>(builder: (context, _dataList, child) {
          return _dataList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return _dataList[index].isFinish
                        ? _taskComplate(_dataList[index])
                        : _taskUnComplate(_dataList[index]);
                  },
                );
        }));
  }

  Future _showDialog(String titleDialog, TodoData task, String buttonText,
      VoidCallback onPressed) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    titleDialog,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    indent: 1,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(task.task.toString()),
                  SizedBox(
                    height: 24,
                  ),
                  CustomDateTimePicker(
                      icon: Icons.date_range,
                      onPressed: _pickerDate,
                      value: DateFormat("dd-MM-yyyy").format(task.date)),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    indent: 1,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                          child: CustomBotton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        textColor: Theme.of(context).accentColor,
                        buttonText: 'Đóng',
                        color: Colors.white, 
                      )),
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: CustomBotton(
                          buttonText: buttonText,
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          onPressed: onPressed,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _taskUnComplate(TodoData todoTask) {
    return InkWell(
      onTap: () {
        _showDialog("Xác nhận công việc ", todoTask, "Hoàn tất", () {
          provider
              .completeTodoEntries(todoTask.id)
              .whenComplete(() => Navigator.of(context).pop());
        });
      },
      onLongPress: () {
        _showDialog("Xóa ghi chú ", todoTask, "Xóa", () {
          provider
              .deleteTodoEntries(todoTask.id)
              .whenComplete(() => Navigator.of(context).pop());
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_unchecked,
              color: Theme.of(context).accentColor,
              size: 20,
            ),
            SizedBox(
              width: 28,
            ),
            Text(todoTask.task.toString())
          ],
        ),
      ),
    );
  }

  Widget _taskComplate(TodoData todoTask) {
    return InkWell(
      onTap: () {
        _showDialog("Xóa ghi chú ", todoTask, "Xóa", () {
          provider
              .deleteTodoEntries(todoTask.id)
              .whenComplete(() => Navigator.of(context).pop());
        });
      },
      onLongPress: () {
        _showDialog("Xóa ghi chú ", todoTask, "Xóa", () {
          provider
              .deleteTodoEntries(todoTask.id)
              .whenComplete(() => Navigator.of(context).pop());
        });
      },
      child: Container(
        foregroundDecoration:
            BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.5)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.radio_button_checked,
                color: Theme.of(context).accentColor,
                size: 20,
              ),
              SizedBox(
                width: 28,
              ),
              Text(
                todoTask.task,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _pickerDate() {}
}
