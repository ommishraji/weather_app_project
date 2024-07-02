import 'dart:convert';

import 'package:http/http.dart' as http;
class weatherData{
  static const apikey = "b4e428669344f60b71d8413ca082a4a5";
  static const apiurl = "https://api.openweathermap.org/data/2.5/weather";
  Future getdata(var url) async {
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> locationweather(String cityName) async{
    var url = "$apiurl?q=${cityName}&appid=$apikey&units=metric";
    var weatherdata = await getdata(url);
    if(weatherdata == null)
      throw Exception('This city name does not exist');
    else
      return weatherdata;
  }
}