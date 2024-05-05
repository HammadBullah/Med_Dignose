import 'dart:io';
import 'package:flutter/material.dart';
import 'package:excel_dart/excel_dart.dart';

class OldUserForm extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController highBPController = TextEditingController();
  final TextEditingController lowBPController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController spo2Controller = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController bloodGlucoseController = TextEditingController();

  Future<void> appendToExcel() async {
    final String documentsPath = '/storage/emulated/0/Documents';
    final String filePath = '$documentsPath/old_user_data.xlsx';
    final File file = File(filePath);

    Excel excel;
    Sheet sheet;

    // If the file exists, open it and get the sheet
    if (await file.exists()) {
      final List<int> existingExcelBytes = await file.readAsBytes();
      excel = Excel.decodeBytes(existingExcelBytes);
      sheet = excel['Sheet1'];
    }
    // If the file doesn't exist, create a new Excel instance and sheet
    else {
      excel = Excel.createExcel();
      sheet = excel['Sheet1'];
      // Add headers to the sheet
      sheet.appendRow([
        'Name',
        'Registration ID',
        'Father/Spouse Name',
        'Contact Number',
        'Height',
        'Weight',
        'High BP',
        'Low BP',
        'Heart Rate',
        'SpO2',
        'Temperature',
        'Blood Glucose',
      ]);
    }

    // Append new data to the sheet
    sheet.appendRow([
      nameController.text,
      dobController.text,
      fatherNameController.text,
      contactNumberController.text,
      heightController.text,
      weightController.text,
      highBPController.text,
      lowBPController.text,
      heartRateController.text,
      spo2Controller.text,
      temperatureController.text,
      bloodGlucoseController.text,
    ]);

    // Save the Excel file
    await file.writeAsBytes(excel.encode()!, flush: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Old User Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(labelText: 'Registration ID'),
              ),
              TextFormField(
                controller: fatherNameController,
                decoration: InputDecoration(labelText: 'Father/Spouse Name'),
              ),
              TextFormField(
                controller: contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid height';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Vitals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: heightController,
                decoration: InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid height';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: highBPController,
                decoration: InputDecoration(labelText: 'High BP'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid high BP';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lowBPController,
                decoration: InputDecoration(labelText: 'Low BP'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid low BP';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heartRateController,
                decoration: InputDecoration(labelText: 'Heart Rate'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid heart rate';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: spo2Controller,
                decoration: InputDecoration(labelText: 'SpO2'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid SpO2';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: temperatureController,
                decoration: InputDecoration(labelText: 'Temperature'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid temperature';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: bloodGlucoseController,
                decoration: InputDecoration(labelText: 'Blood Glucose'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid blood glucose';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {

                    await appendToExcel();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Success'),
                          content: Text('Data saved to Excel file.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the success dialog
                                Navigator.of(context).pop(); // Close the form screen and go back to the previous screen
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('An error occurred: $e'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Submit'),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create numeric text fields
  Widget buildNumericTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}
