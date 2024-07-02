import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:weather_app/Screens/Weather.dart';
import 'package:weather_app/utilities/weatherData.dart';
import '../utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  bool spin = false;
  late String previous_cityName ='';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    print(previous_cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purpleAccent,
                Colors.deepOrangeAccent
              ]
            )
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child:  TextField(
                    controller: controller,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration:kinputdecoration,
                    onChanged: (value){
                      cityName = value;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      spin = true;
                    });
                    controller.clear();
                    try {
                      weatherData wd = weatherData();
                      dynamic data = await wd.locationweather(previous_cityName);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> Weather(data)));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$e'))
                      );
                    }
                    setState(() {
                      spin = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*.75,
                      height: MediaQuery.of(context).size.height*.05,
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index){
                            return previous_cityName == ''? null: Container(
                              width: MediaQuery.of(context).size.width*.7,
                              height: MediaQuery.of(context).size.height*.05,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Last search: $previous_cityName',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      spin = true;
                    });
                    controller.clear();
                    try {
                      weatherData wd = weatherData();
                      dynamic data = await wd.locationweather(cityName);
                      previous_cityName = cityName;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> Weather(data)));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$e'))
                      );
                    }
                    setState(() {
                      spin = false;
                    });
                  },
                  child: Material(
                    elevation: 10,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                      child: const Text(
                        'Get Weather',
                        style: kButtonTextStyle,
                      ),
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
