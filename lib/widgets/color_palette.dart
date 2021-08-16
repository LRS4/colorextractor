import 'package:colorextractor/providers/image_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorPalette extends StatefulWidget {
  @override
  _ColorPaletteState createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  @override
  Widget build(BuildContext context) {
    final imageDetails = Provider.of<ImageDetailsProvider>(context);
    
    return Column(children: [
      Text("Color palette information here"),
      Text(imageDetails.storedImagePath != "" ? imageDetails.storedImagePath : "No image set")
    ]);
  }
}
