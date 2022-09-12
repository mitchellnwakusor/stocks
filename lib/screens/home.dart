
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks/date_and_time.dart';
import 'package:stocks/services/exchange_rates.dart';
import 'package:stocks/utility/custom_text_style.dart';
import '../custom_icons_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomTextStyle customTextStyle = CustomTextStyle();
  ExchangeRate exchangeRate = ExchangeRate();
  DateAndTime dateAndTime = DateAndTime();
  List<DataRow> dataRow = [];

  List<String> dateRanges = [];

  static const String title = 'Market rates';

  String baseSymbol = 'NGN';
  late String startDate;
  late String endDate;
  String source = 'cbn';
  String changeOption = '24 hrs';
  final TextEditingController _searchbar = TextEditingController();

  @override
  void initState(){
    super.initState();

  }



  @override
  void dispose(){
    super.dispose();
    _searchbar.dispose();
  }



  @override
  Widget build(BuildContext context) {

    List? currentSymbols = Provider.of<List?>(context);
    dataRow = currentSymbols!.map((e) => DataRow(cells: [
      DataCell(Text(e.symbolCode)),
      DataCell(Text(e.rate)),
      DataCell(Text(e.fluctuationRate,style: TextStyle(color: e.color),),),
    ])).toList();

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          title,
          style: customTextStyle.title,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          SizedBox(
            width: 120,
            child: DropdownButtonFormField<String>(
                isDense: true,
                isExpanded: false,
                value: baseSymbol,
                elevation: 1,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none
                ),
                items:  [
                  DropdownMenuItem(value: 'NGN',child: Row(
                    children: [
                      Image.asset("assets/NGN.png",height: 24, width: 24,),
                      const SizedBox(width: 4,),
                      const Text('NGN'),
                    ],
                  ),),
                  DropdownMenuItem(value: 'AUD',child:  Row(
                    children: [
                      Image.asset("assets/AUD.png",height: 24, width: 24,),
                      const SizedBox(width: 4,),
                      const Text('AUD'),
                    ],
                  ),),
                  DropdownMenuItem(value: 'CAD',child:  Row(
                    children: [
                      Image.asset("assets/CAD.png",height: 24, width: 24,),
                      const SizedBox(width: 4,),
                      const Text('CAD'),
                    ],
                  ),),
                  DropdownMenuItem(value: 'USD',child:  Row(
                    children: [
                      Image.asset("assets/USD.png",height: 24, width: 24,),
                      const SizedBox(width: 4,),
                      const Text('USD'),
                    ],
                  ),),
                  DropdownMenuItem(value: 'GBP',child:  Row(
                    children: [
                      Image.asset("assets/GBP.png",height: 24, width: 24,),
                      const SizedBox(width: 4,),
                      const Text('GBP'),
                    ],
                  ),),
                  DropdownMenuItem(value: 'EUR', child:  Row(
                    children: [
                      Image.asset("assets/EUR.png",height: 24, width: 24,),
                      const SizedBox(width: 4,),
                      const Text('EUR'),
                    ],
                  ),),
                  DropdownMenuItem(value: 'JPY',child:  Row(
                    children: [
                      Image.asset("assets/JPY.png",height: 24, width: 24,),
                      const SizedBox(width: 4,),
                      const Text('JPY'),
                    ],
                  ),),
                ],
                onChanged: (String? newValue){
                  setState((){
                    baseSymbol = newValue!;
                  });
                }),
          )
        ]
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled: true,
                hintText: 'Search currency',
                // helperText: 'NGN USD GBP EUR',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(Colors.blue.value),width: 2.0)
                ),
              ),
              controller: _searchbar,
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 8,),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              buttonPadding: const EdgeInsets.all(0),
              children: [
                OutlinedButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(BorderSide(color: Color(Colors.blue[700]!.value))),
                    shape: MaterialStateProperty.all( const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.zero,bottomLeft:Radius.circular(8),bottomRight:Radius.zero ))),
                    minimumSize: MaterialStateProperty.all(const Size( 98, 36)),
                  ),
                  child: const Text('Parallel Market'),
                ),
                OutlinedButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.pressed) ? Colors.blue : Colors.white),
                    foregroundColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.pressed) ? Colors.white : Colors.blue),
                    side: MaterialStateProperty.all(BorderSide(color: Color(Colors.blue[600]!.value))),
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                    minimumSize: MaterialStateProperty.all(const Size( 120, 36)),
                  ),
                  child: const Text('P2P'),
                ),
                OutlinedButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.pressed) ? Colors.blue : Colors.white),
                    foregroundColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.pressed) ? Colors.white : Colors.blue),
                    side: MaterialStateProperty.all(BorderSide(color: Color(Colors.blue[600]!.value))),
                    shape: MaterialStateProperty.all( const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.zero,topRight: Radius.circular(8),bottomLeft: Radius.zero,bottomRight:Radius.circular(8) ))),
                    minimumSize: MaterialStateProperty.all(const Size( 128, 36)),
                  ),
                  child: const Text('Bank'),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Expanded(
              child: ListView(
                children: [
                  FittedBox(
                    child: DataTable(
                            horizontalMargin: 16,
                            columns: [
                              const DataColumn(label: Text('Name',style: TextStyle(fontSize: 16),),),
                              DataColumn(label: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  value: source,
                                  items: const [
                                    DropdownMenuItem(value: 'cbn',child: Text('CBN'),),
                                    DropdownMenuItem(value: 'eu',child: Text('EU'),),
                                  ], onChanged: (String? newValue) {
                                  setState((){
                                    source = newValue!;
                                  });
                                },
                                ),
                              )),
                              DataColumn(label: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  value: changeOption,
                                  items: const [
                                    DropdownMenuItem(value: '24 hrs',child: Text('24 hrs'),),
                                    DropdownMenuItem(value: 'Custom date',child: Text('Custom date'),),
                                  ], onChanged: (String? newValue) async {
                                  setState((){
                                    changeOption = newValue!;
                                  });
                                  if(newValue=='Custom date'){
                                  dateRanges = await dateAndTime.setCustomDate(context);
                                  startDate = dateRanges[0];
                                  endDate = dateRanges[1];
                                  print(startDate);
                                  print(endDate);
                                  currentSymbols = await exchangeRate.getData(baseSymbol, 'boi', startDate, endDate).then((value) {
                                    print('${currentSymbols?[0].symbolCode}');
                                      dataRow = currentSymbols!.map((e) => DataRow(cells: [
                                    DataCell(Text(e.symbolCode)),
                                    DataCell(Text(e.rate)),
                                    DataCell(Text(e.fluctuationRate,style: TextStyle(color: e.color),),),
                                  ])).toList();
                                  setState((){});
                                  print(dataRow[0].cells.first.child.toString());});

                                  }
                                  else{
                                  dateRanges = dateAndTime.setCurrentDate();
                                  startDate = dateRanges[0];
                                  endDate = dateRanges[1];
                                  print(startDate);
                                  print(endDate);
                                  }

                                },
                                ),
                              )),
                            ],
                            rows: dataRow,
                        ),
                  ),]
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.exchange_rate_filled__1_), label: 'Rates'),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.exchange), label: 'Convert'),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.book_open), label: 'Blog'),
        ],
        unselectedItemColor: Colors.grey[500],
        iconSize: 24,
      ),
    );
  }
}
