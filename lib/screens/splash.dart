import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stocks/date_and_time.dart';
import 'package:stocks/screens/home.dart';
import 'package:stocks/services/exchange_rates.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  ExchangeRate exchangeRate = ExchangeRate();
  DateAndTime dateAndTime = DateAndTime();
  String startDate = '';
  String endDate = '';
  late Future<List?> ratesRequest;

  @override
  void initState(){
    super.initState();

    List<String> dateHolder = dateAndTime.setCurrentDate();
    startDate = dateHolder[0];
    endDate = dateHolder[1];
    ratesRequest = exchangeRate.getData('NGN', 'cbn', startDate, endDate);
  }

  @override
  Widget build(BuildContext context) {

    return FutureProvider<List?>(
      create: (context) => ratesRequest,
      initialData: const [],
      child: Scaffold(
        //body: FutureBuilder ? HomeScreen with data : SvgPicture
        body: Center(
          child: FutureBuilder<List?>(
            future: ratesRequest,
            builder: (context, snapshot){
              if(snapshot.hasData) {
                return const HomeScreen();
              }
              else{
                return SvgPicture.asset('assets/logo.svg',semanticsLabel: 'stocks logo',height: 256,width: 256,);
              }
            },
          ),
          ),
      ),
    );
  }
}
