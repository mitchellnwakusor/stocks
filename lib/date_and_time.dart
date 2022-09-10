import 'package:flutter/material.dart';
class DateAndTime {
  final DateTime currentDate = DateTime.now();
  late DateTime previousDate;
  final Duration duration = const Duration(days: 1);
  late DateTime startDateTime;
  late DateTime endDateTime;


 List<String> setCurrentDate(){
   startDateTime = currentDate.subtract(duration);
   String startDate = startDateTime.toString().substring(0,10);

   endDateTime = currentDate;
   String endDate = currentDate.toString().substring(0,10);
   List<String> dates = [startDate,endDate];
   print(dates);
   return dates;
 }

Future<List<String>> setCustomDate(BuildContext context) async{
   int year = currentDate.year - 1;
   startDateTime = DateTime(year,currentDate.month,currentDate.day);
   endDateTime = currentDate;

   final DateTimeRange? dateTimeRange = await showDateRangePicker(context: context, firstDate: startDateTime, lastDate: endDateTime);
   if(dateTimeRange==null){
     startDateTime = startDateTime;
   }
   else{
     startDateTime = dateTimeRange.start;
   }

   String startDate = startDateTime.toString().substring(0,10);
   String endDate = endDateTime.toString().substring(0,10);

   List<String> dates = [startDate,endDate];

   print(dates);
   return dates;

 }

}