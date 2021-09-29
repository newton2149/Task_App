import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ActiveTaskCard extends StatelessWidget {
  static List<Color> cl = [
    Colors.lightGreen,
    Colors.blue.shade300,
    Colors.green.shade300,
    Colors.red.shade200,
    Colors.yellow.shade300,
    Colors.orange.shade300,
    Colors.pink.shade300,
  ];
  final String title;
  ActiveTaskCard(this.title);
  @override
  Widget build(BuildContext context) {
    final double percentInt = 0.65;
    return Container(
      height: 150,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: cl[Random().nextInt(cl.length)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularPercentIndicator(
              radius: 90.0,
              lineWidth: 5.0,
              animation: true,
              percent: 0.65,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.redAccent.shade400,
              backgroundColor: Colors.orange.shade300,
              center: CircleAvatar(
                radius: 35,
                child: Center(
                  child: Text(
                    "${percentInt * 100} %",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "$title",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
