import 'package:colorextractor/screens/extract.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/image_details.dart';

class ShowPaletteScreen extends StatefulWidget {
  static const routeName = "/palette";
  @override
  _ShowPaletteScreenState createState() => _ShowPaletteScreenState();
}

class _ShowPaletteScreenState extends State<ShowPaletteScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    ExtractScreen(),
    Text("About"),
    Text("Help")
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
                  text: 'Color Extractor',
                  style: TextStyle(
                    fontSize: 21
                  )
                ),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Icon(Icons.colorize_rounded)
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
              icon: Icon(Icons.info_outline_rounded),
              label: 'About',
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
