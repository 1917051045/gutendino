import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  String username;
  String city;
  bool theme;

  Settings({this.username, this.city, this.theme});
}

class SettingsManager {
  Future saveSettings(Settings settings) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('username', settings.username);
    await preferences.setString('city', settings.city);
    await preferences.setBool('theme', settings.theme);
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();

    final username = preferences.getString('username') ?? "User";
    final city = preferences.getString('city') ?? "Bandar Lampung";
    final theme = preferences.getBool('theme') ?? false;

    return Settings(username: username, city: city, theme: theme);
  }
}
