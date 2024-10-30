import 'package:flutter/material.dart';

class CheckBoxViewModel extends ChangeNotifier {
  List<bool> _check = List.filled(7, false);
  final List<String> _value = ["牛", "豚", "鶏", "魚", "野菜", "スイーツ", "その他"];

  List<bool> get check => _check;
  List<String> get value => _value;

void select(int index) {
  // 現在の選択が同じインデックスかどうかを確認
  if (_check[index]) {
    // 既に選択されている場合はチェックを外す
    _check[index] = false;
  } else {
    // それ以外の場合はすべてのチェックを外して、新しいインデックスを選択
    for (int i = 0; i < _check.length; i++) {
      _check[i] = false;
    }
    _check[index] = true;
  }
  notifyListeners(); // 状態が変わったことを通知
}

  void changeSelect(int index, List<bool> data) {

    if(data[index] ){
      data[index] = false;
    }else{
      for (int i = 0; i < data.length; i++) {
      data[i] = false;
    }
    data[index] = true;
    }
    
    notifyListeners(); // 状態が変わったことを通知
  }
}

