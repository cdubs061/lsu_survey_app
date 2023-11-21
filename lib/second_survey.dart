import '../data_analysis.dart';
import '../ending_page.dart';
import 'custom_dropdown_menu.dart';
import 'package:flutter/material.dart';

class SecondSurvey extends StatefulWidget {

  String username = '';
  String roomNumber = '';
  String thermalSensation1 = '';
  String thermalEnvironment1 = '';
  String thermalComfort1 = '';
  String stressedLevel1 = '';
  DateTime date1;

  SecondSurvey ({
    super.key,
    required this.username,
    required this.roomNumber,
    required this.thermalComfort1,
    required this.thermalSensation1,
    required this.thermalEnvironment1,
    required this.stressedLevel1,
    required this.date1,
  });
  @override
  State<StatefulWidget> createState() => _SecondSurvey();
}
class _SecondSurvey extends State<SecondSurvey> {

  String thermalSensation2 = '';
  String thermalEnvironment2 = '';
  String thermalComfort2 = '';
  String stressedLevel2 = '';
  String googleSheet = '';
  bool questionsAnswered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Question'),
        backgroundColor: Colors.purple.shade900,
      ),
      body: SingleChildScrollView
        (
        child:
        Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //What is your thermal sensation
              const Text(
                'What is your general thermal sensation right now?',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),

              //thermal sensation
              Padding(
                padding: const EdgeInsets.all(10.0),
                // Adjust the padding as needed
                child:
                CustomDropdownMenu(
                  items: const [ 'Cold',
                    'Cool',
                    'Slightly Cool',
                    'Neutral',
                    'Slightly Warm',
                    'Warm',
                    'Hot',
                  ],
                  value: '',
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        thermalSensation2 = newValue;
                        checkQuestions();
                      });
                    }
                  },
                  labelText: 'Select an option',
                ), //thermal environment
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Is the thermal environment acceptable to you in general right now?',
                  style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                // Adjust the padding as needed
                child:
                CustomDropdownMenu(
                  items: const [ 'Acceptable', 'Unacceptable',],
                  value: '',
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        thermalEnvironment2 = newValue;
                        checkQuestions();
                      });
                    }
                  },
                  labelText: 'Select an option',
                ),
              ),
              //How do you assess your level of thermal comfort right now?
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'How do you assess your level of thermal comfort right now? ',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                // Adjust the padding as needed
                child:
                CustomDropdownMenu(
                  items: const [ 'Extremely Dissatisfied',
                    'Dissatisfied', 'Slightly Dissatisfied',
                    'Neither Satisfied Nor Dissatisfied',
                    'Slightly Satisfied', 'Satisfied', 'Extremely Satisfied'],
                  value: '',
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        stressedLevel2 = newValue;
                        checkQuestions();
                      });
                    }
                  },
                  labelText: 'Select an option',
                ),
              ),
              // Do you Feel stressed right now?
              const Text(
                'Do you feel stressed right now?',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomDropdownMenu(
                  items: const [ 'Acceptable', 'Unacceptable',],
                  value: '',
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        thermalComfort2 = newValue;
                        checkQuestions();
                      });
                    }
                  },
                  labelText: 'Select an option',
                ),
              ),
              // did you log google sheets?
              const Text(
                'Did you log the times on Google Sheet?',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomDropdownMenu(
                  items: const [ 'Yes', 'Oops, I\'ll do that now',],
                  value: '',
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        googleSheet = newValue;
                        checkQuestions();
                      });
                    }
                  },
                  labelText: 'Select an option',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: questionsAnswered,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () async {

            DataAnalysis dataAnalysis = DataAnalysis(
                userName: widget.username,
                roomNumber: widget.roomNumber,
                thermalComfort1: widget.thermalComfort1,
                thermalSensation1: widget.thermalSensation1,
                thermalEnvironment1: widget.thermalEnvironment1,
                stressLevel1: widget.stressedLevel1,
                date1: widget.date1,
                thermalComfort2: thermalComfort2,
                thermalEnvironment2: thermalEnvironment2,
                thermalSensation2: thermalSensation2,
                stressLevel2: stressedLevel2,
                googleSheet: googleSheet,
                date2: DateTime.now()
            );

            bool success = await dataAnalysis.sendSurveyData(await dataAnalysis.toMap());

            if(mounted && success) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EndingPage()),
              );
            } else if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                      'Please connect to the LSU wi-fi. If you are connected '
                          'and still receive this error that means the server is down.'
                          'please contact Arup to get the server back up.'),
                  backgroundColor: Colors.red.shade900,
                ),
              );
            }
          },
          tooltip: 'Answer all of the questions',
          child: const Icon(Icons.arrow_forward),
        )
      ),
    );
  }

  void checkQuestions() {
    if (thermalSensation2.isNotEmpty && thermalEnvironment2.isNotEmpty &&
        thermalComfort2.isNotEmpty && stressedLevel2.isNotEmpty && googleSheet.isNotEmpty) {
      setState(() {
        questionsAnswered = true; // Show the button when all questions are answered
      });
    } else {
      setState(() {
        questionsAnswered = false; // Hide the button if any question is not answered
      });
    }
  }
}