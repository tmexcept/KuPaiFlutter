import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'WeatherInfo.dart';

class WeatherInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("创建了 WeatherInfoPage  StatelessWidget");
    return ChangeNotifierProvider(
      create: (context) => WeatherInfo(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Provider Pattern"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "我在ChangeNotifierProvider中，看我变不变${Random().nextInt(100)}"),
              ),
              MyHeader(),
              MyContent(),
              Consumer<WeatherInfo>(
                builder: (context, weatherInfo, child) {
                  print("Consumer  BuilderContext build");
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Consumer 111 type=${weatherInfo.temperatureType}"),
                  );
                },
              ),
              /// 拿到 WeatherInfo 对象，读取数据
              Consumer<WeatherInfo>(
                builder: (ctx, info, child) => Text(info.temperatureType),
              ),

              /// 拿到 WeatherInfo 对象，调用方法
              Consumer<WeatherInfo>(
                builder: (ctx, info, child) {
                  return ElevatedButton(
                    /// 点击按钮，调用方法更新
                    onPressed: () => info.temperatureType = "更新了",
                    child: const Text("点击更新"),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: MyFloatingActionButton(),
      ),
    );
  }
}

class MyHeader extends StatelessWidget {
  Color decideColor(WeatherInfo info) {
    return "celcius" == info.temperatureType ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    print("WeatherInfoPage StatelessWidget MyHeader build");
    WeatherInfo weatherInfo = Provider.of<WeatherInfo>(context);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "我是类中的temperatureType=${weatherInfo.temperatureType}",
        style: TextStyle(
          color: decideColor(weatherInfo),
          fontSize: 20,
        ),
      ),
    );
  }
}

class MyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("WeatherInfoPage StatelessWidget MyContent build");

    return Consumer<WeatherInfo>(
      builder: (context, weatherInfo, child) {
        print("Consumer MyContent build");
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("StatelessWidget包裹的Consumer type=${weatherInfo.temperatureType}"),
        );
      },
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  Color decideColor(WeatherInfo info) {
    return info.temperatureType == "celcius" ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    var weatherInfo = Provider.of<WeatherInfo>(context);
    print("创建 MyFloatingActionButton build");
    return FloatingActionButton(
      backgroundColor: decideColor(weatherInfo),
      onPressed: () {
        String newWeatherType =
            weatherInfo.temperatureType == "celcius" ? "far" : "celcius";
        weatherInfo.temperatureType = newWeatherType;
      },
      tooltip: 'Change  Type',
      child: Icon(Icons.change_history),
    );
  }
}
