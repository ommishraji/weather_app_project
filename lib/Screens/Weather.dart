import 'package:flutter/material.dart';
import 'package:weather_app/utilities/IconProvider.dart';
import 'package:weather_app/utilities/weatherData.dart';
import '../utilities/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class Weather extends StatefulWidget {
  dynamic weatherData;
  Weather(this.weatherData);

  @override
  _WeatherState createState() => _WeatherState();
}


class _WeatherState extends State<Weather> {
  late int temperature;
  late String cityname;
  late String humidity;
  late String icon;
  late String wind;
  late String condition;
  bool spin = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }
  void updateUI(dynamic data){
    setState(() {
      IconProvider ip = IconProvider();
      double tempo = data['main']['temp'];
      temperature = tempo.toInt();
      var condition_code = data['weather'][0]['id'];
      icon = ip.getWeatherIcon(condition_code);
      condition = data['weather'][0]['main'];
      humidity = data['main']['humidity'].toString();
      wind = data['wind']['speed'].toString();
      cityname = data['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purpleAccent,
              Colors.deepOrangeAccent
            ],
          ),
        ),
        child: ModalProgressHUD(
          inAsyncCall: spin,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async{
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          spin = true;
                        });
                        weatherData wd = weatherData();
                        dynamic data2 = await wd.locationweather(cityname);
                        updateUI(data2);
                        spin = false;
                      },
                      child: const Icon(
                        Icons.refresh,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:  <Widget>[
                          Text(
                            '$temperature°',
                            style: kTempTextStyle,
                          ),
                          Text(
                            icon,
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                      Text('Humidity - $humidity%',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 30
                        ),
                      ),
                      Text('Wind speed - $wind m/s',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 30
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.1, right: 20),
                  child: Text('$cityname has $condition',
                    softWrap: true,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 30
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
