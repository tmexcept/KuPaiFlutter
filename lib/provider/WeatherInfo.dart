import 'package:flutter/material.dart';

class WeatherInfo with ChangeNotifier {
  String _tempType = "celcius";
  int _temperatureVal = 25;


  WeatherInfo(){
    print("WeatherInfo constructor");
  }

  init(){
    print("WeatherInfo init()");
  }

  String get temperatureType => _tempType;

  set temperatureType(String value) {
    _tempType = value;
    notifyListeners();
  }

  int get temperatureVal => _temperatureVal;

  set temperatureVal(int value) {
    _temperatureVal = value;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    print("WeatherInfo dispose()");
  }
}

