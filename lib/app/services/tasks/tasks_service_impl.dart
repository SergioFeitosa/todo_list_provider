// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/week_tasks_model.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository;

  bool showFinishedTasks = false;

  @override
  Future<void> save(DateTime date, String description, String userId) =>
      _tasksRepository.save(date, description, userId);

  @override
  Future<List<TaskModel>> getToday(String userId) {
    return _tasksRepository.findByPeriod(
        DateTime.now(), DateTime.now(), userId);
  }

  @override
  Future<List<TaskModel>> getTomorrow(String userId) {
    var tomorrowDate = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findByPeriod(tomorrowDate, tomorrowDate, userId);
  }

  @override
  Future<WeekTasksModel> getWeek(String userId) async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }

    endFilter = startFilter.add(const Duration(days: 7));

    var tasks =
        await _tasksRepository.findByPeriod(startFilter, endFilter, userId);

    return WeekTasksModel(
        startDate: startFilter, endDate: endFilter, tasks: tasks);
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) =>
      _tasksRepository.checkOrUncheckTask(task);

  @override
  Future<void> deleteTask(TaskModel task) => _tasksRepository.deleteTask(task);
}
