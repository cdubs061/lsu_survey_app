import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import '../second_survey.dart';

class WaitingSurvey extends StatefulWidget {
  
  String username = '';
  String roomNumber = '';
  String thermalSensation1 = '';
  String thermalEnvironment1 = '';
  String thermalComfort1 = '';
  String stressedLevel1 = '';

  WaitingSurvey({
    super.key,
    required this.username, // Add the variables as parameters
    required this.roomNumber,
    required this.thermalComfort1,
    required this.thermalSensation1,
    required this.thermalEnvironment1,
    required this.stressedLevel1,
  });
  
  @override
  State<StatefulWidget> createState() => _waitingSurvey();
  }



class _waitingSurvey extends State<WaitingSurvey> {

  String username ='';
  String thermalSensation1 = '';
  String thermalEnvironment1 = '';
  String thermalComfort1 = '';
  String stressedLevel1 = '';

  bool isTimerFinished = false;
  int remainingMinutes = 0;
  int remainingSeconds = 2;
   late Timer timer;

   @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to prevent memory leaks
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
        title: const Text('Waiting for Next Survey'),
        backgroundColor: Colors.purple.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ClockIcon(),
            const SizedBox(height: 16),
            Text(
              'Please wait for AT LEAST $remainingMinutes:${remainingSeconds.toString().padLeft(2, '0')} to end',
              style: const TextStyle(
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
                  roomNumber: widget.roomNumber,
                  thermalComfort1: widget.thermalComfort1,
                  thermalSensation1: widget.thermalSensation1,
                  thermalEnvironment1: widget.thermalEnvironment1,
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
  const ClockIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
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

    const angle = 2 * pi; // 360 degrees in radians

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