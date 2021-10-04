import 'package:flutter/material.dart';
import 'package:gutendino/data/weather_service.dart';
import 'package:gutendino/models/weather.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _dataService = DataService();
  WeatherResponse _response;

  void initState() {
    super.initState();
    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    if (_response != null) {
      return Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        _response.cityName,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Divider(color: Colors.black),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.teal[300],
                        child: Image.network(_response.iconUrl),
                      ),
                      Text(
                        _response.weatherInfo.main,
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  )
                ],
              ),
              Divider(color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '${_response.mainInfo.temperature}°ᶜ',
                        style: TextStyle(fontSize: 40),
                      )
                    ],
                  )
                ],
              ),
              Divider(color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '${_response.mainInfo.humidity}%',
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(
                        'Humidity',
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  )
                ],
              ),
              Divider(color: Colors.black),
            ],
          ),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  void _getWeather() async {
    final response = await _dataService.getWeather("Bandar Lampung");
    setState(() => _response = response);
  }
}
