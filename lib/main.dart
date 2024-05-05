import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'newuserform.dart';
import 'olduserform.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Data Collection App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Data Collection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewUserForm()),
                );
              },
              child: Text('New User Form'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OldUserForm()),
                );
              },
              child: Text('Old User Form'),
            ),
            ElevatedButton(
              onPressed: () {
                _exportFiles(context);
              },
              child: Text('Export Excel Files'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportFiles(BuildContext context) async {
    // Get the directory where the files are saved
    final String documentsPath = '/storage/emulated/0/Documents';
    final File oldUserFile = File('$documentsPath/old_user_data.xlsx');
    final File newUserFile = File('$documentsPath/new_user_data.xlsx');

    if (!(await oldUserFile.exists()) || !(await newUserFile.exists())) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Excel files not found.'),
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

    // Share the files
    final List<String> filePaths = [oldUserFile.path, newUserFile.path];
    await Share.shareFiles(
      filePaths,
      text: 'Here are the Excel files.',
    );
  }
}
