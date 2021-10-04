import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gutendino/main.dart';
import 'package:gutendino/models/settings_manager.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _preferencesService = SettingsManager();

  final _usernameController = TextEditingController();
  String _city = "Bandar Lampung";
  var _theme = false;

  @override
  void initState() {
    _populateFields();
    super.initState();
  }

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();
    setState(() {
      _usernameController.text = settings.username;
      _city = settings.city ?? "Bandar Lampung";
      _theme = settings.theme ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
          ),
          SwitchListTile(
              title: Text('Dark Mode'),
              value: _theme,
              onChanged: (newValue) => setState(() => _theme = newValue)),
          TextButton(onPressed: _saveSettings, child: Text('Save Settings'))
        ],
      ),
    );
  }

  void _saveSettings() {
    final newSettings = Settings(
        username: _usernameController.text, city: _city, theme: _theme);
    _preferencesService.saveSettings(newSettings);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyApp()));
  }
}
