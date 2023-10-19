import 'main.dart';
import 'Second Survey.dart';
import 'SurveyQuestion.dart';

class DataAnalysis {
  String userName = '';
  int userAge = 18;
  String userGender = '';
  String userRace = '';
  String userEducation = '';
  String thermalSensation1 = '';
  String thermalEnvironment1 = '';
  String thermalComfort1 = '';
  String stressedLevel1 = '';

  String thermalSensation2 = '';
  String thermalEnvironment2 = '';
  String thermalComfort2 = '';
  String stressedLevel2 = '';


  DataAnalysis
  ( {
    required this.userName,
    required this.userAge,
    required this.userGender,
    required this.userRace,
    required this.userEducation,
    required this.thermalComfort1,
    required this.thermalSensation1,
    required this.thermalEnvironment1,
    required this.stressedLevel1,
    required this.thermalComfort2,
    required this.thermalSensation2,
    required this.thermalEnvironment2,
    required this.stressedLevel2,
} );



}