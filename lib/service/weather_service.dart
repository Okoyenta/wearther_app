import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:wearther_app/model/weather_model.dart';
import 'package:http/http.dart' as http;
// Import geocoding package

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if(response.statusCode == 200){
      // print(jsonDecode(response.body));
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load weather data');
    }
  }

  // Future<String> getCurrentCity() async {
  //   // Get permission from the user
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if(permission == LocationPermission.denied){
  //     permission = await Geolocator.requestPermission();
  //   }
  //
  //   // Fetch current position
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.low
  //   );
  //
  //   // Convert location into a list of placemark objects
  //   List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  //
  //   // Check if placemarks list is empty
  //   if (placemarks.isEmpty) {
  //     return "Unknown"; // Return "Unknown" if no placemarks are found
  //   }
  //
  //   // Extract city name from the placemark
  //   String? city = placemarks[0].locality;
  //
  //   return city ?? "miami"; // Return "Unknown" if city is null
  // }

  // Future<String> getCurrentLocation() async {
  //   String address = '';
  //   try {
  //     // Get permission from the user
  //       LocationPermission permission = await Geolocator.checkPermission();
  //       if(permission == LocationPermission.denied){
  //         permission = await Geolocator.requestPermission();
  //       }
  //       print('permision:  $permission');
  //
  //     // Fetch the user's current position
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //       print('position:  $position');
  //
  //     // Reverse geocode the coordinates to get the address
  //     // List<Placemark> placemarks =
  //     // await placemarkFromCoordinates(position.latitude, position.longitude);
  //     //   print('place marks:  $placemarks');
  //
  //       List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
  //       print('place marks locations:  $locations');
  //
  //       List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
  //       print('place marks:  $placemarks');
  //
  //     // Concatenate the address components
  //     address = '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}';
  //     print(address);
  //   } catch (e) {
  //     // Handle any errors that occur during the process
  //     print('Error getting location: $e');
  //     address = 'Error getting location';
  //   }
  //   return address;
  // }

}
