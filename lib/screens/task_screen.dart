import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_app/components/calender_item.dart';
import 'package:intl/intl.dart';
import 'package:task_app/components/meeting_show.dart';
import 'package:task_app/models/meeting.dart';
import 'package:task_app/provider/meeting_provider.dart';
import 'package:task_app/provider/ui_provider.dart';
import 'package:task_app/screens/add_task_form.dart';

class TaskScreen extends StatelessWidget {
  static const routName = "/task-screen";
  static TextStyle customStyleTitle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
  );
  static TextStyle customStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
  );
  List get dateList {
    var now = DateTime.now();
    var startDate = now.subtract(Duration(days: now.weekday));
    var listDate = List.generate(7, (i) {
      return startDate.add(Duration(days: i)).day;
    });
    return listDate;
  }

  List get dateListOrg {
    var now = DateTime.now();
    var startDate = now.subtract(Duration(days: now.weekday));
    var listDate = List.generate(7, (i) {
      return startDate.add(Duration(days: i));
    });
    return listDate;
  }

  List get dayNameList {
    var now = DateTime.now();
    var startDate = now.subtract(Duration(days: now.weekday));
    var listDate = List.generate(7, (i) {
      return "${DateFormat.E().format(startDate.add(Duration(days: i)))}";
    });

    return listDate;
  }

  @override
  Widget build(BuildContext context) {
    final date = Provider.of<UiProvider>(context);
    final data = Provider.of<UserMeeting>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Tasks",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        elevation: 0,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.notifications_outlined,
        //       color: Colors.black,
        //     ),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.more_vert_outlined,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Today",
                    style: customStyleTitle,
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(NewTask.routName);
                    },
                    child: Text(
                      "Add Task",
                      style: customStyle,
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade400),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Productive Day, ${FirebaseAuth.instance.currentUser!.displayName}",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 8, bottom: 20),
              child: Text(
                DateFormat("MMMM, y").format(DateTime.now()),
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Consumer<UiProvider>(
              builder: (context, data, child) => Container(
                height: 100,
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    return CalendarItem(
                        dateList[i], dayNameList[i], dateListOrg[i]);
                  },
                  itemCount: dateList.length,
                ),
              ),
            ),

            // Consumer<UserMeeting>(
            //   builder: (context, data, child) => ListView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemBuilder: (ctx, i) => Meetingcard(
            //         id: data.sortItemByDate(date.dateTimeSelected)[i].id,
            //         title: data.sortItemByDate(date.dateTimeSelected)[i].title,
            //         description: data
            //             .sortItemByDate(date.dateTimeSelected)[i]
            //             .description,
            //         time: data
            //             .sortItemByDate(date.dateTimeSelected)[i]
            //             .timeStart),
            //     itemCount: data.sortItemByDate(date.dateTimeSelected).length,
            //   ),
            // ),

            StreamBuilder<QuerySnapshot>(
              // <2> Pass `Stream<QuerySnapshot>` to stream
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .where("day", isEqualTo: date.dateTimeSelected.day)
                  .snapshots(includeMetadataChanges: true),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  print(documents);
                  return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: documents.map((DocumentSnapshot doc) {
                        print(doc.get("date"));
                        print(Timestamp.fromDate(date.dateTimeSelected));

                        return Meetingcard(
                            id: doc.get("id"),
                            title: doc.get("title"),
                            description: doc.get("description"),
                            time: TimeOfDay.now());
                      }).toList());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (!snapshot.hasData) {
                  return Text("Add new Tasks");
                } else {
                  debugPrint(snapshot.error.toString());
                  return Text(" ");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
