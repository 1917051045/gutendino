import 'package:flutter/material.dart';
import 'package:gutendino/models/settings_manager.dart';
import 'package:gutendino/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';
import 'models/manager_models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _preferencesService = SettingsManager();

  Settings _sett =
      Settings(username: "User", city: "Bandar Lampung", theme: false);

  @override
  void initState() {
    super.initState();
    _populateSettings();
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
    return MaterialApp(
      title: 'Gutendino',
      theme: _sett.theme ? GutendinoTheme.dark() : GutendinoTheme.light(),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TabManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => ToDoManager(),
          ),
        ],
        child: const Home(),
      ),
      backgroundColor: Colors.teal[100],
      image: Image.asset('assets/images/splash.png'),
      photoSize: 100.0,
      loaderColor: Colors.redAccent[700],
      loadingText: Text("Loading", style: TextStyle(color: Colors.black)),
    );
  }
}
