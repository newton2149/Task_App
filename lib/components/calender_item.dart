import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/ui_provider.dart';

class CalendarItem extends StatelessWidget {
  final int dayNo;
  final String dayName;

  final DateTime dateSelected ;

  CalendarItem(this.dayNo, this.dayName,this.dateSelected);
  static TextStyle customStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
  );
  static TextStyle customStyleTitle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UiProvider>(context);
    return GestureDetector(
      onTap: () {
        data.updateTime(dateSelected);
      },
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          height: 50,
          width: 53,
          decoration: BoxDecoration(
            color: dayName == DateFormat("EEE").format(data.dateTimeSelected)
                ? Colors.yellow
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "$dayName",
                  style: customStyle,
                ),
              ),
              Center(
                child: Text(
                  "$dayNo",
                  style: customStyleTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
