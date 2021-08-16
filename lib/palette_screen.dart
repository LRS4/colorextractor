import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';
import '../widgets/color_palette.dart';
import 'providers/image_details.dart';

class ShowPaletteScreen extends StatefulWidget {
  static const routeName = "/palette";
  @override
  _ShowPaletteScreenState createState() => _ShowPaletteScreenState();
}

class _ShowPaletteScreenState extends State<ShowPaletteScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (context) => ImageDetailsProvider(),
    child: Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Icon(Icons.palette_outlined)
                  ),
                ),
                TextSpan(
                  text: 'Color Extractor',
                  style: TextStyle(
                    fontSize: 21
                  )
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
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
            ElevatedButton.icon(
                icon: Icon(Icons.colorize),
                label: Text("Extract Colors"),
                onPressed: () { },
                style: ButtonStyle(
                    foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero
                    ),
                    elevation: MaterialStateProperty.all<double>(0.0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.purple.shade300),
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
      )
    );
  }
}
