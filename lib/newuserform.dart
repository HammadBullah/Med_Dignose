import 'dart:io';
import 'package:flutter/material.dart';
import 'package:excel_dart/excel_dart.dart';

class NewUserForm extends StatefulWidget {
  @override
  _NewUserFormState createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController alternativeNumberController =
  TextEditingController();
  final TextEditingController aadharNumberController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController highBPController = TextEditingController();
  final TextEditingController lowBPController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController spo2Controller = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController bloodGlucoseController = TextEditingController();

  DateTime? selectedDate;

  Future<void> createExcel(String fileName, List<List<dynamic>> data) async {
    final String documentsPath = '/storage/emulated/0/Documents';
    final String filePath = '$documentsPath/$fileName';
    final File file = File(filePath);

    Excel excel;
    Sheet sheet;

    if (await file.exists()) {
      final List<int> existingExcelBytes = await file.readAsBytes();
      excel = Excel.decodeBytes(existingExcelBytes);
      sheet = excel['Sheet1'];
    } else {
      excel = Excel.createExcel();
      sheet = excel['Sheet1'];
      sheet.appendRow([
        'Name',
        'Date of Birth',
        'Father/Spouse Name',
        'Contact Number',
        'Address',
        'Alternative Number',
        'Aadhar Number',
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

    for (var rowData in data) {
      sheet.appendRow(rowData);
    }

    await file.writeAsBytes(excel.encode()!, flush: true);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New User Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dobController,
                    decoration: InputDecoration(labelText: 'Date of Birth'),
                  ),
                ),
              ),
              TextField(
                controller: fatherNameController,
                decoration: InputDecoration(labelText: 'Father/Spouse Name'),
              ),
              TextFormField(
                controller: contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid contact number';
                  }
                  return null;
                },
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: alternativeNumberController,
                decoration:
                InputDecoration(labelText: 'Alternative Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid alternative number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: aadharNumberController,
                decoration: InputDecoration(labelText: 'Aadhar Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid Aadhar number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Health Parameters',
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
                  if (selectedDate == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please select Date of Birth'),
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
                    return;
                  }
                  List<List<dynamic>> userData = [
                    [
                      nameController.text,
                      selectedDate!.toString(),
                      fatherNameController.text,
                      contactNumberController.text,
                      addressController.text,
                      alternativeNumberController.text,
                      aadharNumberController.text,
                      heightController.text,
                      weightController.text,
                      highBPController.text,
                      lowBPController.text,
                      heartRateController.text,
                      spo2Controller.text,
                      temperatureController.text,
                      bloodGlucoseController.text,
                    ]
                  ];
                  await createExcel('new_user_data.xlsx', userData);
                  Navigator.of(context).pop(); // Navigate back to home screen
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
