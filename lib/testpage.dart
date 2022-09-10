import 'package:flutter/material.dart';
import 'package:stocks/date_and_time.dart';


class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  DateAndTime dateAndTime = DateAndTime();

  @override
  Widget build(BuildContext context) {
  dateAndTime.setCurrentDate();
    return Scaffold(
      body: Center(child: Text('Hello'),),
    );
  }
}
