import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/database.dart';
import 'package:todolist/models/todolist.dart';
import 'package:todolist/widgets/custom_button.dart';
import 'package:todolist/widgets/custom_date_time_picker.dart';
import 'package:todolist/widgets/custom_model_action.dart';
import 'package:todolist/widgets/custom_textfield.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  DateTime _selectedDate = DateTime.now(); 
  TimeOfDay _selectedTime = TimeOfDay.now();  
  final _textTaskController = TextEditingController();
  final _textDescriptionController = TextEditingController();
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

  Future _pickerTime() async {
    TimeOfDay timepick = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    if (timepick != null)
      setState(() {
        _selectedTime = timepick;
      });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Database>(context);
    //_textTaskController.clear();
    //_textDescriptionController.clear();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              "Thêm sự kiện",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Theme.of(context).accentColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(height: 1,indent: 1,),
          SizedBox(
            height: 10,
          ),
          CustomDateTimePicker(
              icon: Icons.date_range,
              onPressed: _pickerDate,
              value: DateFormat("dd-MM-yyyy").format(_selectedDate) ),
          CustomDateTimePicker(
              icon: Icons.access_time,
              onPressed: _pickerTime,
              value: _selectedTime.toString()),
         SizedBox(
            height: 10,
          ),
          Divider(height: 1,indent: 1,),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            labelText: 'sự kiện',
            controller: _textTaskController,
          ),
          SizedBox(
            height: 24,
          ),
          CustomTextField(
            labelText: 'mô tả',
            controller: _textDescriptionController,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(height: 1,indent: 1,),
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
              }
              else{
                provider.insertTodoEntries(new TodoData(
                  date:_selectedDate,
                  time: new DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute),
                  isFinish: false,
                  task: _textTaskController.text,
                  description: _textDescriptionController.text,
                  todoType: TodoType.TYPE_EVENT.index,
                  id:null
                )).whenComplete(()=>Navigator.of(context).pop());
            }},
          ),
        ],
      ),
    );
  }
}
