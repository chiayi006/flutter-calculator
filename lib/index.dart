import 'package:calculator/calculate.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  static const Color PAGE_COLOR = Colors.black;
  static const Color NUM_BTN_BG = Color(0xFF303030);
  static const Color TOP_BTN_BG = Color(0xFFD6D6D6);
  static const Color RIGHT_BTN_BG = Colors.orange;

  static const List<String> NKeys = [
    'C', 'AC', '?', '/', //
    '9', '8', '7', '*', //
    '6', '5', '4', '-', //
    '3', '2', '1', '+', //
    '', '0', '.', '=', //
  ];
  static const List<String> TKeys = [
    'C',
    'AC',
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
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  String _num = '';

  Calculate _cal = new Calculate();

  void clickKey(String key) {
    _cal.addKey(key);
    setState(() {
      _num = _cal.output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IndexPage.PAGE_COLOR,
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(color: Colors.white,fontSize: 32),
        ),
        backgroundColor: IndexPage.PAGE_COLOR,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '$_num',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                      ),
                    ),
                  ),
                ),
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
        onPressed: () {
          clickKey(num);
        },
        child: Container(
          decoration: BoxDecoration(
            color: IndexPage.TKeys.contains(num)
                ? IndexPage.TOP_BTN_BG
                : IndexPage.RKeys.contains(num)
                    ? IndexPage.RIGHT_BTN_BG
                    : IndexPage.NUM_BTN_BG,
            shape: flex > 1 ? BoxShape.rectangle : BoxShape.circle,
            borderRadius:
                flex > 1 ? BorderRadius.all(Radius.circular(50)) : null,
          ),
          padding: EdgeInsets.all(15),
          child: Center(
            child: Text(
              '$num',
              style: TextStyle(
                  fontSize: 32,
                  color: IndexPage.TKeys.contains(num)
                      ? Colors.black
                      : Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBtns() {
    List<Widget> rows = [];
    List<Widget> btns = [];
    int flex = 1;

    for (int i = 0; i < IndexPage.NKeys.length; i++) {
      String key = IndexPage.NKeys[i];

      
      if (key.isEmpty) {
        flex++;
        continue;
      } else {
        Widget b = buildTextButton(key, flex: flex);
        btns.add(b);
        flex = 1;
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
}
