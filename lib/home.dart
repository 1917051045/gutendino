import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gutendino/models/settings_manager.dart';
import 'package:gutendino/screens/screens.dart';
import 'package:gutendino/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'models/tab_manager.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    DashScreen(),
    ToDoScreen(),
    WeatherScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(
      builder: (context, tabManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'GUTENDINO',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingScreen()),
                    );
                  },
                  icon: Icon(Icons.settings))
            ],
          ),
          body: IndexedStack(index: tabManager.selectedTab, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: tabManager.selectedTab,
            onTap: (index) {
              tabManager.goToTab(index);
            },
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'To Do List',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.cloud),
                label: 'Weather',
              ),
            ],
          ),
        );
      },
    );
  }
}
