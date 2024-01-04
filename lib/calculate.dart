class Calculate {
  String _output = '';
  String _curnum = '';
  double result = 0.0;

  String get output => this._output;

  List<String> _s1 = [];
  List<String> _s2 = [];
  List<double> _s3 = [];

  static const List<String> NKeys = [
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2',
    '1',
    '0',
    '.',
  ];

  static const List<String> TKeys = [
    'C',
    'AC',
    '?',
  ];

  static const RKeysMap = {'/': 2, '*': 2, '-': 1, '+': 1};
  List<String> _keys = [];

  static const List<String> RKeys = [
    '/',
    '*',
    '-',
    '+',
  ];

  static const EQ = '=';

  void addKey(String key) {
    if (TKeys.contains(key)) {
      switch (key) {
        case 'C':
          _s1 = [];
          _s2 = [];
          _s3 = [];
          _curnum = '';
          _output = '';
          _keys = [];
          break;
        case 'AC':
          removeLastKey();
          break;
      }
      return;
    }

    String prekey = '';
    if (_keys.length > 0) {
      prekey = _keys[_keys.length - 1];
    }

    if (NKeys.contains(key)) {
      if (_curnum.isEmpty && _s1.isEmpty) {
        _output = '';
      }
      _output += key;
      _curnum += key;
      _keys.add(key);
    } else {
      if (_curnum.isNotEmpty) {
        _s1.add(_curnum);
        _curnum = '';
      }
    }

    if (RKeys.contains(key)) {
      if (_s1.length == 0) {
        String rs = result.toString();
        _output = rs;
        for (int i = 0; i < rs.length; i++) {
          _keys.add(rs.substring(i, i + 1));
        }
        _s1.add(rs);
      }
      if (RKeys.contains(prekey)) {
        removeLastKey();
      }
      _keys.add(key);
      _output += key;
      if (_s2.length == 0) {
        _s2.add(key);
      } else {
        String lastkey = _s2[_s2.length - 1];
        if (RKeysMap[key]! <= RKeysMap[lastkey]!) {
          while (_s2.length > 0 &&
              RKeysMap[key]! <= RKeysMap[_s2[_s2.length - 1]]!) {
            _s1.add(_s2.removeLast());
          }
        }
        _s2.add(key);
      }
    }

    if (EQ == key && (_s1.length > 0 || _curnum.isNotEmpty) && prekey != EQ) {
      if (RKeys.contains(prekey)) {
        removeLastKey();
      }
      _keys.add(key);
      _output += key;
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
      _keys = [];
    }
  }

  void removeLastKey() {
    if (_keys.isEmpty) {
      return;
    }

    String prekey = _keys.removeLast();

    if (RKeys.contains(prekey)) {
      // Handle operators
      while (_s1.isNotEmpty) {
        String tk = _s1.removeLast();
        if (RKeys.contains(tk)) {
          _s2.add(tk);
        } else {
          break;
        }
      }
      _s2.removeLast();
    } else if (_curnum.isNotEmpty) {
      // Handle numbers
      _curnum = _curnum.substring(0, _curnum.length - 1);
    } else if (_s1.isNotEmpty) {
      // Handle the case when there are items in _s1
      String tk = _s1.removeLast();
      tk = tk.substring(0, tk.length - 1);
      if (tk.isNotEmpty) {
        _s1.add(tk);
      }
    }

    // Update _output
    _output = _output.substring(0, _output.length - 1);
  }
}
