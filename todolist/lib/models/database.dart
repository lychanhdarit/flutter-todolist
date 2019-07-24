
import 'package:flutter/foundation.dart';
import 'package:todolist/models/todolist.dart';
import 'package:moor_flutter/moor_flutter.dart';
part 'database.g.dart'; 

@UseMoor(
  
  tables:[Todo],
  queries: {
    '_getByType':'SELECT * FROM todo WHERE todo_type = ?',
    '_completeTask':'UPDATE todo SET is_finish = 1 WHERE id = ?',
    '_deleteTask':'DELETE FROM todo  WHERE id = ?',
  }

) 
 
class Database extends _$Database with ChangeNotifier {
  Database() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'dbtodos.sqlite'));

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1; 
   
  Stream<List<TodoData>> getTodoByType(int type) => watchGetByType(type);

  Future insertTodoEntries(TodoData entry){
    print('add task');
    return transaction((tx) async {
      await tx.into(todo).insert(entry);
    });
  }

  Future completeTodoEntries(int id){
    return transaction((tx) async {
      await _completeTask(id, operateOn: tx);
    });
  }

   Future deleteTodoEntries(int id){
    return transaction((tx) async {
      await _deleteTask(id, operateOn: tx);
    });
  }
}