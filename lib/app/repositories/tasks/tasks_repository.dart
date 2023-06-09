import 'package:todo_list_provider/app/models/task_model.dart';

abstract class TasksRepository {
  Future<void> save(DateTime date, String description, String userId);
  Future<List<TaskModel>> findByPeriod(
      DateTime start, DateTime end, String userId);
  Future<void> checkOrUncheckTask(TaskModel task);
  Future<void> deleteTask(TaskModel task);
}
