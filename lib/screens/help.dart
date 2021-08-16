import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(24),
      children: [
        Text(
          "Getting Started",
          style: TextStyle(
            fontSize: 20,
            color: Colors.teal.shade700
          )
        ),
        SizedBox(height: 8),
        Text(
          "Welcome to Color Palette Extractor, we're really pleased you chose this app! " +
          "You can get started by either taking a photo or selecting a previously taken " +
          "photo via the gallery. You will need to allow the app to access the camera " +
          "and gallery when prompted.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.teal.shade700
          )
        ),
        SizedBox(height: 8),
        Text(
          "Extracting Colors",
          style: TextStyle(
            fontSize: 20,
            color: Colors.teal.shade700
          )
        ),
        SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal.shade700
                ),
                text: "Once you've taken a photo or selected a photo from the gallery the app will " +
                      "automatically extract colors and display them along with their "
              ),
              TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal.shade700,
                  decoration: TextDecoration.underline
                ),
                text: "hex codes.",
                recognizer: TapGestureRecognizer()..onTap = () async {
                  String url = "https://en.wikipedia.org/wiki/Web_colors#Hex_triplet";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw "Cannot load URL";
                  }
                }
              )
            ]
          )
        ),
        SizedBox(height: 8),
        Text(
          "Focused Extraction",
          style: TextStyle(
            fontSize: 20,
            color: Colors.teal.shade700
          )
        ),
        SizedBox(height: 8),
        Text(
          "If you want to extract colors from a certain section of the photo " +
          "draw a rectangle around the image preview and the colors will be updated.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.teal.shade700
          )
        ),
        SizedBox(height: 8),
        Text(
          "Happy Color Extracting!",
          style: TextStyle(
            fontSize: 20,
            color: Colors.teal.shade700
          )
        ),
        SizedBox(height: 8),
        Text(
          "Now you're ready to extract colors from real life! We hope you love using " +
          "this app as much as we do. The app was inspired by designing websites " +  
          "and finding CSS color codes. We aim to keep making the app even better through " + 
          "updates. Once again, thanks for supporting us!",
          style: TextStyle(
            fontSize: 16,
            color: Colors.teal.shade700
          )
        ),
      ]
    );
  }
}
