import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  static const Color PAGE_COLOR = Colors.black;
  static const Color NUM_BTN_BG = Color(0xff323232);
  static const Color TOP_BTN_BG = Color(0xFFa6a6a6);
  static const Color RIGHT_BTN_BG = Color(0xFFff9500);

  static const List<String> NKeys = [
    'C', 'D', '?', '/', //
    '9', '8', '7', '*', //
    '6', '5', '4', '-', //
    '3', '2', '1', '+', //
    '','0', '.', '=', //
  ];
  static const List<String> TKeys = [
    'C',
    'D',
    '?',
  ];
  static const List<String> RKeys = [
    '/',
    '*',
    '-',
    '+',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_COLOR,
      appBar: AppBar(
        title: Text('Calculator',style: TextStyle(color: Colors.white),),
        backgroundColor: PAGE_COLOR,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text('output'),
              ),
            ),
            Container(
              child: Center(child: _buildBtns()),
            )
          ],
        )),
      ),
    );
  }

  Widget buildTextButton(String num, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: TextButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
                color: TKeys.contains(num)
                    ? TOP_BTN_BG
                    : RKeys.contains(num)
                        ? RIGHT_BTN_BG
                        : NUM_BTN_BG,
                shape: flex > 1 ? BoxShape.rectangle : BoxShape.circle,
                borderRadius:
                    flex > 1 ? BorderRadius.all(Radius.circular(1000)) : null),
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                '$num',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
          )),
    );
  }
}

Widget _buildBtns() {
  List<Widget> rows = [];
  List<Widget> btns = [];
  int flex = 1;

  for (int i = 0; i < IndexPage.NKeys.length; i++) {
    String key = IndexPage.NKeys[i];
    if(key.isEmpty){
      flex++;
      continue;
    }else{
      Widget b = IndexPage().buildTextButton(key,flex:flex);
      btns.add(b);
      flex=1;
    }
    
    if ((i + 1) % 4 == 0) {
      rows.add(Row(
        children: btns,
      ));
      btns = [];
    }
  }
  if (btns.length > 0) {
    rows.add(Row(
      children: btns,
    ));
    btns = [];
  }

  return Column(
    children: rows,
  );
}
