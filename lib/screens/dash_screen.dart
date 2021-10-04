import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gutendino/data/weather_service.dart';
import 'package:gutendino/models/settings_manager.dart';
import 'package:gutendino/models/weather.dart';
import 'package:intl/intl.dart';

class DashScreen extends StatefulWidget {
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  final _dataService = DataService();
  final _preferencesService = SettingsManager();

  Settings _sett =
      Settings(username: "User", city: "Bandar Lampung", theme: false);

  WeatherResponse _response;

  void initState() {
    _populateSettings();
    _getWeather();
    super.initState();
  }

  void _populateSettings() async {
    final _settings = await _preferencesService.getSettings();
    setState(() {
      _sett.username = _settings.username ?? "User";
      _sett.city = _settings.city ?? "Bandar Lampung";
      _sett.theme = _settings.theme ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_response != null) {
      return Scaffold(
        body: StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            return Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat('MM/dd/yyyy H:mm:ss')
                              .format(DateTime.now()),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          DateTime.now().hour < 12 && DateTime.now().hour > 5
                              ? "Good Morning, ${_sett.username}"
                              : DateTime.now().hour < 17
                                  ? "Good Afternoon, ${_sett.username}"
                                  : DateTime.now().hour < 21
                                      ? "Good Evening, ${_sett.username}"
                                      : "Good Night, ${_sett.username}",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.teal[300],
                              child: Image.network(_response.iconUrl),
                            ),
                            Text(
                              _response.weatherInfo.main,
                              style: Theme.of(context).textTheme.headline3,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${_response.mainInfo.temperature}°ᶜ',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text(
                              'Temprature',
                              style: Theme.of(context).textTheme.headline3,
                            )
                          ],
                        ),
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
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _response.cityName,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "To Do List",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ],
                ));
          },
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  void _getWeather() async {
    final response = await _dataService.getWeather('${_sett.city}');
    setState(() => _response = response);
  }
}
