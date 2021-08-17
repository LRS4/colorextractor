import 'package:colorextractor/screens/extract.dart';
import 'package:colorextractor/screens/help.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/image_details.dart';

class Navigation extends StatefulWidget {
  static const routeName = "/home";
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  List<String> _appBarTitleOptions = [
    "Color Palette Extractor",
    "Help"
  ];
  List<Icon> _appBarIconOptions = [
    Icon(Icons.colorize_outlined),
    Icon(Icons.help_outline)
  ];
  List<Widget> _widgetOptions = <Widget>[
    ExtractScreen(),
    HelpScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (context) => ImageDetailsProvider(),
    child: Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: _appBarTitleOptions[_selectedIndex],
                  style: TextStyle(
                    fontSize: 21
                  )
                ),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: _appBarIconOptions[_selectedIndex]
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.colorize_outlined),
              label: 'Extract',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'Help',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          onTap: _onItemTapped,
        ),
      )
    );
  }
}
