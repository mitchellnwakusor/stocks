import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:stocks/symbol.dart';

class ExchangeRate{

  List symbols = [];

  List<String> symbolsCode = [];
  List<String> symbolsRates = [];
  List<Color> symbolColors = [];
  List<String> symbolsFluctuationRates = [];
  String errorMessage = '';

  convertRate(var rate){
    var price = 1 / rate;
    return price;
  }
  Future<List?> requestFluctuationRates(String base, String source, String startDate, String endDate) async {
    String apiUrl = 'https://api.exchangerate.host/fluctuation?base=$base&source=$source&start_date=$startDate&end_date=$endDate'; //2020-01-01 date-format
    String val;
    Color symbolColor;
    try {
      Response response = await get(Uri.parse(apiUrl));
      if(response.body.isEmpty){
        errorMessage = 'Request failed: ${response.statusCode.toString()}';
        print(errorMessage);
      }
      else{
        List<String> fluctuationRates = [];
        List<Color> colors = [];
        var data = jsonDecode(response.body);
        Map rates = data['rates'];
        rates.forEach((key, value) {
          val = value['change_pct'].toString();
          if(val=='null'){
            val='0';
          }
          if(val[0] != '-' && val.length>1){
            val = '+$val%';
            symbolColor = Colors.green;
          }
          else if(val[0] != '-' && val.length==1){
            val = '$val%';
            symbolColor = Colors.black;
          }
          else{
            val = '$val%';
            symbolColor = Colors.red;
          }
         fluctuationRates.add(val);
         colors.add(symbolColor);
        });

        symbolsFluctuationRates = fluctuationRates;
        symbolColors = colors;
      }
    } catch (e) {
      errorMessage = e.toString();
      print(errorMessage);
    }
    return symbolsFluctuationRates;
  }
  Future<List?> requestLatestRates(String base, String source) async {
    String apiUrl = 'https://api.exchangerate.host/latest?base=$base&source=$source'; //2020-01-01 date-format
    double convertedRate;
    try {
      Response response = await get(Uri.parse(apiUrl));
      if(response.body.isEmpty){
        errorMessage = 'Request failed: ${response.statusCode.toString()}';
        print(errorMessage);
      }
      else{
        List<String> currentRates = [];
        var data = jsonDecode(response.body);
        Map rates = data['rates'];

        rates.forEach((key, value) {
          convertedRate = convertRate(value);

          currentRates.add(convertedRate.toString());

          symbolsRates = currentRates;
        });
      }
    } catch (e) {
      errorMessage = e.toString();
      print(errorMessage);
      
    }
    return symbolsRates;
  }
  Future<List?> requestSymbolCodes(String base, String source) async{
    String apiUrl = 'https://api.exchangerate.host/latest?base=$base&source=$source'; //2020-01-01 date-format
    try {
      Response response = await get(Uri.parse(apiUrl));
      if(response.body.isEmpty){
        errorMessage = 'Request failed: ${response.statusCode.toString()}';
        print(errorMessage);
      }
      else{
        List<String> code = [];
        var data = jsonDecode(response.body);
        Map rates = data['rates'];
        rates.forEach((key, value) {
          code.add(key);
          symbolsCode = code;
        });
      }
    } catch (e) {
      errorMessage = e.toString();
      print(errorMessage);
    }
    return symbolsCode;

  }

  Future<List?> createSymbolObject(List symbol, List rate, List fluctuationRate,List color) async{
    for(int i = 0; i < symbol.length; i++){
      symbols.add(MarketSymbol(symbol[i],rate[i],fluctuationRate[i],color[i]));
    }


    return symbols;
    // print(symbols[3].symbolCode);
    // print(symbols[3].rate);
    // print(symbols[3].fluctuationRate);
    // print(symbols[3].color);
    // print(symbols.length);
  }

  Future<List?> getData(String base, String source, String startDate, String endDate) async{
    await requestFluctuationRates(base, source, startDate, endDate);
    await requestSymbolCodes(base, source);
    await requestLatestRates(base, source);

    return createSymbolObject(symbolsCode, symbolsRates, symbolsFluctuationRates, symbolColors);
  }
}