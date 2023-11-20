import '../waiting_survey.dart';
import 'custom_dropdown_menu.dart';
import 'package:flutter/material.dart';

class SurveyQuestion extends StatefulWidget
{
  const SurveyQuestion({super.key});

  @override
  State<StatefulWidget> createState() => _SurveyQuestion();
}

class _SurveyQuestion extends State<SurveyQuestion> {
  String username ='';
  String roomNumber = '';
  String thermalSensation = '';
  String thermalEnvironment = '';
  String thermalComfort = '';
  String stressedLevel = '';
  bool questionAnswered = false;

  _SurveyQuestion();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                const Text(
                  'Where are you participating from?',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomDropdownMenu(
                    items: const [ 'PFT 2210', 'PFT 3133',],
                    value: '',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          roomNumber = newValue;
                          checkQuestions();
                        });
                      }
                    },
                    labelText: 'Select an option',
                  ),
                ),
                // What is your thermal sensation
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
                          thermalSensation = newValue;
                          checkQuestions();
                        });
                      }
                    },
                    labelText: 'Select an option',
                  ),
                  //thermal environment
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
                    items: const ['Acceptable', 'Unacceptable',],
                    value: '',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          thermalEnvironment = newValue;
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
                          stressedLevel = newValue;
                          checkQuestions();
                        });
                      }
                    },
                    labelText: 'Select an option',
                  ),
                ),
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
                          thermalComfort = newValue;
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
            visible: questionAnswered,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WaitingSurvey(
                      username: username,
                      roomNumber: roomNumber,
                      thermalComfort1: thermalComfort,
                      thermalSensation1: thermalSensation,
                      thermalEnvironment1: thermalEnvironment,
                      stressedLevel1: stressedLevel)
                  ),
                );
              },
              tooltip: 'Answer all of the questions',
              child: const Icon(Icons.arrow_forward),
            )
        ),

      ),


    );
  }

  void checkQuestions() {
    if (thermalSensation.isNotEmpty && thermalEnvironment.isNotEmpty &&
        thermalComfort.isNotEmpty && stressedLevel.isNotEmpty) {
      setState(() {
        questionAnswered = true; // Show the button when all questions are answered
      });
    } else {
      setState(() {
        questionAnswered = false; // Hide the button if any question is not answered
      });
    }
  }
}