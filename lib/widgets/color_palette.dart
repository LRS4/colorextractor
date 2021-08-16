import 'package:colorextractor/providers/image_details.dart';
import 'package:colorextractor/widgets/palette_swatch.dart';
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
      // Text(imageDetails.storedImagePath != "" ? imageDetails.storedImagePath : "No image set"),
      Padding(
        padding: EdgeInsets.only(top: 40),
        child: PaletteSwatches(generator: imageDetails.paletteGenerator)
      )
    ]);
  }
}
