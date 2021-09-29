import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_app/components/categories_item.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/meeting_provider.dart';
import 'package:uuid/uuid.dart';

class NewTask extends StatelessWidget {
  static const routName = "/new-task";
  final TextStyle customStyleTitle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.indigo.shade900,
      fontSize: 30,
    ),
  );
  final TextStyle customStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontSize: 20,
    ),
  );

  final Color bgColour = Colors.blue.shade200;

  static List<String> name = [
    "meeting",
    "sports",
    "office",
    "study",
    "science",
    "play"
  ];

  TimeOfDay selectedTimeStart = TimeOfDay.now();

  TimeOfDay selectedTime = TimeOfDay.now();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserMeeting>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColour,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var uuid = Uuid();
          data.addMeeting(uuid.v1());
          Navigator.of(context).pop();
        },
        child: Icon(Icons.add),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgColour,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8,
                      ),
                      child: Text(
                        "Create new task",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade700,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: data.titleController,
                        decoration: InputDecoration(
                          labelText: "Title",
                          hintText: "eg:Finish My Homework",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<UserMeeting>(
                      builder: (context, data, child) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  ).then((pickedDate) {
                                    if (pickedDate == null) {
                                      return;
                                    }
                                    data.updateDate(pickedDate);
                                  });
                                  print('...');
                                },
                                icon:
                                    Icon(Icons.arrow_drop_down_circle_outlined),
                              ),
                              labelText:
                                  "${DateFormat("MMMM, d").format(data.dateSelected)}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.45,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Consumer<UserMeeting>(
                      builder: (context, data, child) => TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText:
                              "${data.timeSelectedStart.format(context)}",
                          suffixIcon: IconButton(
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((pickedTime) {
                                if (pickedTime == null) {
                                  return;
                                }
                                data.updateTimeStart(pickedTime);
                              });
                              print('...');
                            },
                            icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.45,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Consumer<UserMeeting>(
                      builder: (context, data, child) => TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "${data.timeSelectedEnd.format(context)}",
                          suffixIcon: IconButton(
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((pickedTime) {
                                if (pickedTime == null) {
                                  return;
                                }
                                data.updateTimeEnd(pickedTime);
                              });
                              print('...');
                            },
                            icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer<UserMeeting>(
                  builder: (context, data, child) => TextFormField(
                    controller: data.descriptionController,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Add a description",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Categories",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      ...NewTask.name.map((e) => CategoriesItem(e)).toList(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
