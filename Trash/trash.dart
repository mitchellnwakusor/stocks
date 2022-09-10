// String baseSymbol = 'NGN';
// String source = 'cbn';
// List<String> _symbols = [];
// List<String> _symbolRates = [];
// List<String> fluctuationRates = [];
// int listCounter = 0;
// List<DataRow> dataRowList = [];
// String startDate = '2022-07-28';
// String endDate = '2022-08-29';
//
// getLatestRate(String base, String source, List<String> symbols, List<String> symbolRates, List<DataRow> dataRowL) async{
//   try {
//     Response response = await get(Uri.parse('https://api.exchangerate.host/latest?places=4&base=$base&source=$source'));
//     final data = jsonDecode(response.body);
//       try{
//         Map rates = data['rates'];
//         rates.forEach((key, value) {
//           symbols.add(key);
//           symbolRates.add(convertRate(value).toString());
//           dataRowL.add(DataRow(cells: [
//             DataCell(Text(key)),
//             DataCell(Text(convertRate(value).toString())),
//             DataCell(Text(fluctuationRates[listCounter]))
//           ]));
//           listCounter++;
//         });
//         _symbols = symbols;
//         _symbolRates = symbolRates;
//         dataRowList = dataRowL;
//       }
//       catch (e) {
//         print('error: $e');
//       }
//
//   }catch (e) {
//     // TODO
//     print('error $e');
//   }
//
// }
// getFluctuationRate(String sDate, String eDate, String symbolSource, List<String> fluctuationRatesList ) async {
//   try {
//     Response response = await get(Uri.parse('https://api.exchangerate.host/fluctuation?places=3&start_date=$sDate&end_date=$eDate&source=$symbolSource'));
//     Map data = jsonDecode(response.body);
//     Map rates = data['rates'];
//     try {
//       rates.forEach((key, value) {
//         if(value['change_pct'] == null){
//           value['change_pct'] = 0;
//         }
//         fluctuationRatesList.add(value['change_pct'].toString());
//       });
//       fluctuationRates = fluctuationRatesList;
//     } catch (e) {
//       print(e.toString());
//     }
//   } catch (e) {
//     print(e.toString());
//   }
//
// }
// getRate()  async{
//   await getFluctuationRate(startDate, endDate, source, fluctuationRates);
//   await getLatestRate(baseSymbol, source, _symbols, _symbolRates, dataRowList);
//   // print(_symbols);
//   // print(_symbolRates);
//   // print(fluctuationRates);
//   // print(dataRowList);
// }
//