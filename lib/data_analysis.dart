import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataAnalysis {
  String? userName = '';
  String roomNumber = '';
  String thermalSensation1 = '';
  String thermalEnvironment1 = '';
  String thermalComfort1 = '';
  String stressLevel1 = '';
  DateTime date1;

  String thermalSensation2 = '';
  String thermalEnvironment2 = '';
  String thermalComfort2 = '';
  String stressLevel2 = '';
  String googleSheet = '';
  DateTime date2;


  DataAnalysis ({
    required this.userName,
    required this.roomNumber,
    required this.thermalComfort1,
    required this.thermalSensation1,
    required this.thermalEnvironment1,
    required this.stressLevel1,
    required this.date1,
    required this.thermalComfort2,
    required this.thermalSensation2,
    required this.thermalEnvironment2,
    required this.stressLevel2,
    required this.googleSheet,
    required this.date2
  });

  Future<Map<String, dynamic>> toMap() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('username');

    return {
      'username': userName,
      'roomNumber': roomNumber,
      'thermalSensation1': thermalSensation1,
      'thermalEnvironment1': thermalEnvironment1,
      'thermalComfort1': thermalComfort1,
      'stressLevel1': stressLevel1,
      'date1': date1.toIso8601String(),

      'thermalSensation2': thermalSensation2,
      'thermalEnvironment2': thermalEnvironment2,
      'thermalComfort2': thermalComfort2,
      'stressLevel2': stressLevel2,
      'googleSheet': googleSheet,

      'date2': date2.toIso8601String(),
    };
  }

  Future<File> _createTempFile(String content) async {
    final String formattedDate = DateFormat('yyyy_MM_dd').format(date2);

    final String fileName = '${userName}_$formattedDate';
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    return file.writeAsString(content);
  }

  Future<bool> _sendToServer(File file) async {
    var uri = Uri.parse('http://96.125.114.42:5000/upload');
    var request = http.MultipartRequest('POST', uri);

    // Add file to the request
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    try {
      var response = await request.send().timeout(const Duration(seconds: 2));
      if (response.statusCode != 200) {
        return false;
      }
    } on TimeoutException catch (_) {
      // Handle timeout situation
      return false;
    }
    return true;
  }

  Future<bool> sendSurveyData(Map<String, dynamic> surveyData) async {
    // Convert the data to a CSV format
    String csvData = _toCsv(surveyData);
    File file = await _createTempFile(csvData);
    // Send the data to the server or save it locally
    bool success = await _sendToServer(file);
    // Or, if saving locally:
    // await _saveLocally(csvData);
    return success;
  }

  String _toCsv(Map<String, dynamic> data) {
    List<String> values = data.values.map((e) => '"$e"').toList();
    return values.join(',');
  }
}