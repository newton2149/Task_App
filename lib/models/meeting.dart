import 'package:flutter/material.dart';

class Meeting {
  final String id;
  final String title;
  final String description;
  final TimeOfDay timeStart;
  final TimeOfDay timeEnd;
  final DateTime date;
  String category = "";

  Meeting({
    required this.id,
    required this.title,
    required this.description,
    required this.timeStart,
    required this.timeEnd,
    required this.date,
  });
}
