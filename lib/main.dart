import 'package:flutter/material.dart';
import 'package:stocks/screens/home.dart';
import 'package:stocks/screens/splash.dart';
import 'package:stocks/testpage.dart';

void main() => runApp(const Stocks());

class Stocks extends StatefulWidget {
  const Stocks({Key? key}) : super(key: key);

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: TestPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}



