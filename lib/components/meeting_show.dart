import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/meeting_provider.dart';

class Meetingcard extends StatelessWidget {
  final String title;
  final String description;
  final TimeOfDay time;
  final String id;
  Meetingcard({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
  });
  static List<Color> cl = [
    Colors.lightGreen,
    Colors.blue.shade300,
    Colors.green.shade300,
    Colors.red.shade200,
    Colors.yellow.shade300,
    Colors.orange.shade300,
    Colors.pink.shade300,
  ];

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserMeeting>(context, listen: false);
    return Dismissible(
      confirmDismiss: (direction) async => await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Confirm"),
          content: Text("Do you want to delete this task"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("OK"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("CANCEL"),
            ),
          ],
        ),
      ),
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete_outline, size: 30, color: Colors.white),
              SizedBox(width: 30),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35)),
            color: Colors.red,
          ),
        ),
      ),
      onDismissed: (direction) {
        data.delete(id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dismissed'),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35)),
            color: cl[Random().nextInt(cl.length)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20),
                    child: Text(
                      "$title",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 20),
                    child: Text(
                      "${time.format(context)}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, bottom: 30),
                child: Text(
                  "$description",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
