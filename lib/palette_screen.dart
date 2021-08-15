import 'package:flutter/material.dart';

class ShowPaletteScreen extends StatefulWidget {
  static const routeName = "/palette";
  @override
  _ShowPaletteScreenState createState() => _ShowPaletteScreenState();
}

class _ShowPaletteScreenState extends State<ShowPaletteScreen> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Extractor")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("User inputs..."),
          ElevatedButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text("Take Photo"),
            onPressed: () {
              
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
              elevation: MaterialStateProperty.all<double>(0.0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateProperty.all<Color>(Colors.purple.shade300),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.red)
                )
              ) 
            )
          )
        ],
      ) 
    );
  }
}