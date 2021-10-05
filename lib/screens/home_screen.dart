import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_app/components/bar_chart.dart';
import 'package:task_app/screens/notification_screen.dart';
import 'package:task_app/screens/task_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routName = "/home-screen";

  static TextStyle customStyleTitle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.indigo.shade900,
      fontSize: 30,
    ),
  );

  static TextStyle customStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontSize: 20,
    ),
  );
  static Color bgColour = Colors.blue.shade200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColour,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationScreen.routName);
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/app-settings");
            },
            icon: Icon(
              Icons.settings_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgColour,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircularPercentIndicator(
                                radius: 90.0,
                                lineWidth: 5.0,
                                animation: true,
                                percent: 0.65,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.redAccent.shade400,
                                backgroundColor: bgColour,
                                center: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      FirebaseAuth
                                          .instance.currentUser!.displayName
                                          .toString()[0]
                                          .toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    FirebaseAuth
                                        .instance.currentUser!.displayName
                                        .toString(),
                                    style: customStyleTitle,
                                  ),
                                  Text("App Devoloper", style: customStyle),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Text(
                  "Weekly Report",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(TaskScreen.routName);
                  },
                  child: Text(
                    "My Calendar",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lime),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BarChartSample3(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 20),
              child: Text(
                "My Tasks",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.alarm_outlined),
              ),
              title: Text("To Do",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  )),
              subtitle: Text(
                "5 tasks now, 1 started",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.circle_outlined),
              ),
              title: Text("In Progress",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  )),
              subtitle: Text(
                "1 tasks now, 1 started",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.done),
              ),
              title: Text("Done",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  )),
              subtitle: Text(
                "15 tasks now, 18 started",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
