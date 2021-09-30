

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app/models/meeting.dart';
import 'package:intl/intl.dart';

class UserMeeting with ChangeNotifier {
  final CollectionReference tasks;
  UserMeeting(this.tasks);
  List<Meeting> _userMeeting = [];
  DateTime dateSelected = DateTime.now();
  TimeOfDay timeSelectedStart = TimeOfDay.now();
  TimeOfDay timeSelectedEnd = TimeOfDay.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<Meeting> get getUserMeeting {
    return [..._userMeeting];
  }

  void cleanForm() {
    dateSelected = DateTime.now();
    timeSelectedStart = TimeOfDay.now();
    timeSelectedEnd = TimeOfDay.now();
    titleController.clear();
    descriptionController.clear();
  }

  void addMeeting(String id) async {
    Meeting newMeeting = Meeting(
      id: id,
      title: titleController.text,
      description: descriptionController.text,
      timeStart: timeSelectedStart,
      timeEnd: timeSelectedEnd,
      date: dateSelected,
    );

    Map<String, dynamic> jsonData = {
      "id": id,
      "title": titleController.text,
      "description": descriptionController.text,
      "timeStart": formatTimeOfDay(timeSelectedStart),
      "timeEnd": formatTimeOfDay(timeSelectedEnd),
      "date": dateSelected,
      "day": dateSelected.hashCode,
    };
    print(formatTimeOfDay(timeSelectedStart));
    try {
      final response = await tasks.add(jsonData);
      print("User Added");
      _userMeeting.add(newMeeting);
      print(_userMeeting);
      cleanForm();
      notifyListeners();
    } catch (error) {
      print(error);
      return;
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  TimeOfDay stringToTime(String s) {
    TimeOfDay _startTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]),
        minute: int.parse(s.split(":")[1].split(" ")[0]));
    return _startTime;
  }

  void updateTimeStart(TimeOfDay time) {
    timeSelectedStart = time;
    notifyListeners();
  }

  void updateTimeEnd(TimeOfDay time) {
    timeSelectedEnd = time;
    notifyListeners();
  }

  void updateDate(DateTime date) {
    dateSelected = date;
    notifyListeners();
  }

  List<Meeting> sortItemByDate(DateTime date) {
    List<Meeting> requiredList = [];
    for (Meeting i in _userMeeting) {
      if (i.date.day == date.day) {
        requiredList.add(i);
      }
    }
    return requiredList;
  }

  void delete(String id) {
    for (Meeting i in _userMeeting) {
      if (i.id == id) {
        _userMeeting.remove(i);
        notifyListeners();
        return;
      }
    }
  }
}
