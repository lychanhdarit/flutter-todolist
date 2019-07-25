import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/database.dart';
import 'package:todolist/models/todolist.dart'; 
import 'package:todolist/widgets/custom_date_time_picker.dart';
import 'package:todolist/widgets/custom_model_action.dart';
import 'package:todolist/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';
class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now(); 
  final _textTaskController = TextEditingController();
  Future _pickerDate() async {
    DateTime datepick = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().add(Duration(days: -365)),
      lastDate: new DateTime.now().add(Duration(days: 365)),
    );
    if (datepick != null)
      setState(() {
        _selectedDate = datepick;
      });
  }
   
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Database>(context);
   // _textTaskController.clear();
    return Padding(
      padding: const EdgeInsets.all(10.0), 
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: <Widget>[
          Center(
            child: Text(
              "Thêm ghi chú",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Theme.of(context).accentColor),
            ),
          ),
         SizedBox(
            height: 10,
          ),
          Divider(height: 1,indent: 1,color: Theme.of(context).accentColor,),
          SizedBox(
            height: 10,
          ),
          CustomDateTimePicker(
              icon: Icons.date_range,
              onPressed: _pickerDate,
              value:  DateFormat("dd-MM-yyyy").format(_selectedDate) ),
         SizedBox(
            height: 10,
          ),
          Divider(height: 1,indent: 1,),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            labelText: 'nhập ghi chú',controller: _textTaskController,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(height: 1,indent: 1,color: Theme.of(context).accentColor,),
          SizedBox(
            height: 10,
          ),
          CustomModelAction(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {
              if(_textTaskController.text==""){
                print("data not found");
              }else{
                provider.insertTodoEntries(new TodoData(
                  date:_selectedDate,
                  time:DateTime.now(),
                  isFinish: false,
                  task: _textTaskController.text,
                  description: "",
                  todoType: TodoType.TYPE_TASK.index,
                  id:null
                )).whenComplete(()=>Navigator.of(context).pop());
              }
            },
          ),
        ],
      ),
    );
  }
}
