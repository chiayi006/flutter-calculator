class Cal {
  String _output ='';
  String _curnum = '';
  double result = 0.0;

  String get output => this._output;

  List<String> _s1 = [];
  List<String> _s2 = [];
  List<double> _s3 = [];

  static const List<String> NKeys = [
    '9', '8', '7',
    '6', '5', '4',
    '3', '2', '1',
    '0', '.',
  ];

  static const List<String> TKeys = [
    'C',
    'D',
    '?',
  ];

  static const RKeysMap = {
    '/': 2, '*': 2, '-': 1, '+': 1
  };

  static const List<String> RKeys = [
    '/',
    '*',
    '-',
    '+',
  ];

  static const EQ = '=';

  void addKey(String key) {
    if (NKeys.contains(key)) {
      _output += key;
      _curnum += key;
    } else {
      _s1.add(_curnum);
      _curnum = '';
      _output += key;
    }

    if (RKeys.contains(key)) {
      if (_s2.length == 0) {
        _s2.add(key);
      } else {
        String lastkey = _s2[_s2.length - 1];
        if (RKeysMap[key]! <= RKeysMap[lastkey]!) {
          while (_s2.length > 0) {
            _s1.add(_s2.removeLast());
          }
        }
        _s2.add(key);
      }
    }

    if (EQ == key) {
      while (_s2.length > 0) {
        _s1.add(_s2.removeLast());
      }
      for (int i = 0; i < _s1.length; i++) {
        String k = _s1[i];
        if (!RKeys.contains(k)) {
          _s3.add(double.parse(k));
        } else {
          switch (k) {
            case '+':
              _s3.add(_s3.removeLast() + _s3.removeLast());
              break;
            case '*':
              _s3.add(_s3.removeLast() * _s3.removeLast());
              break;
            case '-':
              double r1 = _s3.removeLast(), r2 = _s3.removeLast();
              _s3.add(r2 - r1);
              break;
            case '/':
              double r1 = _s3.removeLast(), r2 = _s3.removeLast();
              _s3.add(r2 / r1);
              break;
          }
        }
      }
      result = _s3[0];
      _output += '$result';
      _s3 = [];
      _s2 = [];
      _s1 = [];
    }
  }
}
