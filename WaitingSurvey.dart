

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'Second Survey.dart';
class WaitingSurvey extends StatefulWidget
{


  String username ='';
  int age = 0;
  String gender = '';
  String race = '';
  String levelOfEdu = '';
  String thermalSensation1 = '';
  String thermalEnviroment1 = '';
  String thermalComfort1 = '';
  String stressedLevel1 = '';

  WaitingSurvey
  ({
    required this.username, // Add the variables as parameters
    required this.age,
    required this.gender,
    required this.race,
    required this.levelOfEdu,
    required this.thermalComfort1,
    required this.thermalSensation1,
    required this.thermalEnviroment1,
    required this.stressedLevel1,

});
  @override
  State<StatefulWidget> createState() => _waitingSurvey(
    username: username,
    age: age,
    gender: gender,
    race: race,
    levelOfEdu: levelOfEdu,
    thermalComfort1: thermalComfort1,
    thermalSensation1: thermalSensation1,
    thermalEnviroment1: thermalEnviroment1,
    stressedLevel1: stressedLevel1,
  );

  }



class _waitingSurvey extends State<WaitingSurvey>
{
  String username ='';
  int age = 0;
  String gender = '';
  String race = '';
  String levelOfEdu = '';
  String thermalSensation1 = '';
  String thermalEnviroment1 = '';
 String thermalComfort1 = '';
  String stressedLevel1 = '';

  _waitingSurvey({
    required this.username,
    required this.age,
    required this.gender,
    required this.race,
    required this.levelOfEdu,
    required this.thermalComfort1,
    required this.thermalSensation1,
    required this.thermalEnviroment1,
    required this.stressedLevel1,
  });



  bool isTimerFinished = false;
  int remainingMinutes =1;
  int remainingSeconds = 0;
   late Timer timer;

   @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      if (remainingMinutes == 0 && remainingSeconds == 0) {
        checkTimer();
        timer.cancel(); // Stop the timer when time is up
        // You can navigate to the next screen or enable the "proceed" button here.
      } else {
        setState(() {
          if (remainingSeconds == 0) {
            remainingMinutes--;
            remainingSeconds = 59;
          } else {
            remainingSeconds--;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Waiting for Next Survey'),
        backgroundColor: Colors.purple.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClockIcon(),
            SizedBox(height: 16),
            Text(
              'Please wait for $remainingMinutes:${remainingSeconds.toString().padLeft(2, '0')} to end',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
          visible: isTimerFinished ,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondSurvey(
                  username: widget.username,
                  age: widget.age,
                  gender: widget.gender,
                  race: widget.race,
                  levelOfEdu: widget.levelOfEdu,
                  thermalComfort1: widget.thermalComfort1,
                  thermalSensation1: widget.thermalSensation1,
                  thermalEnviroment1: widget.thermalEnviroment1,
                  stressedLevel1: widget.stressedLevel1,)),
              );
            },
            tooltip: 'Until the timer is Finished',
            child: const Icon(Icons.arrow_forward),
          )
      ),
    );

  }
  void checkTimer()
  {
    if(remainingMinutes == 0 && remainingSeconds == 0)
      {
        setState(() {
          isTimerFinished = true;
        });
      }
  }
}


class ClockIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: ClockPainter(),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final angle = 2 * pi; // 360 degrees in radians

    canvas.drawCircle(center, radius, paint);
    canvas.drawLine(
      center,
      Offset(center.dx, center.dy - radius),
      paint,
    );

    final linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var i = 0; i < 12; i++) {
      final x1 = center.dx + cos(-angle / 12 * i) * (radius - 20);
      final y1 = center.dy + sin(-angle / 12 * i) * (radius - 20);
      final x2 = center.dx + cos(-angle / 12 * i) * radius;
      final y2 = center.dy + sin(-angle / 12 * i) * radius;
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }


}