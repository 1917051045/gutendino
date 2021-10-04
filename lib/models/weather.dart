class WeatherInfo {
  final String main;
  final String icon;

  WeatherInfo({this.main, this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final icon = json['icon'];
    return WeatherInfo(main: main, icon: icon);
  }
}

class MainInfo {
  final double temperature;
  final int humidity;
  MainInfo({this.temperature, this.humidity});

  factory MainInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    final humidity = json['humidity'];
    return MainInfo(temperature: temperature, humidity: humidity);
  }
}

class WeatherResponse {
  final String cityName;
  final MainInfo mainInfo;
  final WeatherInfo weatherInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse({this.cityName, this.mainInfo, this.weatherInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    final mainInfoJson = json['main'];
    final mainInfo = MainInfo.fromJson(mainInfoJson);

    return WeatherResponse(
        cityName: cityName, mainInfo: mainInfo, weatherInfo: weatherInfo);
  }
}
