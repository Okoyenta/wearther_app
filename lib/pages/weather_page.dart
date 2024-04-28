import 'package:flutter/material.dart';
import 'package:wearther_app/model/weather_model.dart';
import 'package:wearther_app/service/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //apiKey
  final WeatherService _weatherService = WeatherService('057f09873e01fe43307e48a2b5f8d00b');

  Weather? _weather;

  //fetch weather
  void _fetchWeather() async {
    String city = 'texas';
    //get the current city
    // String cityName = await _weatherService.getCurrentCity();
    // print("--------------------");
    // print(cityName);
    // print("----------------------");


    //get weather for city
    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch(e) {
      print("Error fetching current city: $e");
    }

  }

  // void _getLocation() async {
  //   String location = await _weatherService.getCurrentLocation();
  //   setState(() {
  //     city = location;
  //     print(city);
  //   });
  // }

  //weather animation
  String getWeatherAnimtion(String? mainCondition ){
    if (mainCondition == null) return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //init State
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetch weather on startup
    // _getLocation();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
            'THANK YOU',
        style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Colors.blue[100],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //cityname
            Text(_weather?.cityName.toUpperCase() ?? 'i love you die, thank you'),

            //Animation
            Lottie.asset(getWeatherAnimtion(_weather?.mainCondition)),

            //temp
            Text('${_weather?.temperature.round()}C'),

            //weathr condition=
            Text(_weather?.mainCondition.toUpperCase()  ?? ""),
            TextButton(
              onPressed: () {
                _fetchWeather();
              },
              child: const Text('press'),
            ),
          ],
        ),
      ),
    );
  }
}

