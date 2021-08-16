
import 'package:colorextractor/widgets/color_palette.dart';
import 'package:colorextractor/widgets/image_input.dart';
import 'package:flutter/material.dart';

class ExtractScreen extends StatefulWidget {
  @override
  _ExtractScreenState createState() => _ExtractScreenState();
}

class _ExtractScreenState extends State<ExtractScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
      Expanded(
        child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
          children: <Widget>[
            //TextField(
            //decoration: InputDecoration(labelText: "Title")
            //),
            SizedBox(height: 10),
            ImageInput(),
            ColorPalette(),
          ],
          )
        )
        )
      ),
      ],
    );
  }
}
