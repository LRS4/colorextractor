import 'dart:io';
import 'package:colorextractor/providers/image_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class ImageInput extends StatefulWidget {
  @override 
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  final GlobalKey imageKey = GlobalKey();
  Rect? _region = Offset.zero & Size(200.0, 200.0);
  Rect? _dragRegion;
  Offset? _startDrag;
  Offset? _currentDrag;

  // Called when the user starts to drag
  void _onPanDown(DragDownDetails details) {
    final RenderBox box =
        imageKey.currentContext!.findRenderObject()! as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    setState(() {
      _startDrag = localPosition;
      _currentDrag = localPosition;
      _dragRegion = Rect.fromPoints(localPosition, localPosition);
    });
  }

  // Called as the user drags: just updates the region, not the colors.
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _currentDrag = _currentDrag! + details.delta;
      _dragRegion = Rect.fromPoints(_startDrag!, _currentDrag!);
    });
  }

  // Called if the drag is canceled (e.g. by rotating the device or switching
  // apps)
  void _onPanCancel() {
    setState(() {
      _dragRegion = null;
      _startDrag = null;
    });
  }

  // Called when the drag ends. Sets the region, and updates the colors.
  Future<void> _onPanEnd(DragEndDetails details) async {
    final Size? imageSize = imageKey.currentContext?.size;
    Rect? newRegion;

    if (imageSize != null) {
      newRegion = (Offset.zero & imageSize).intersect(_dragRegion!);
      if (newRegion.size.width < 4 && newRegion.size.width < 4) {
        newRegion = Offset.zero & imageSize;
      }
    }
    
    setState(() {
      _region = newRegion;
      _dragRegion = null;
      _startDrag = null;
    });
  }

  @override 
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageDetailsProvider>(context);

    return Row(
      children: <Widget>[
        Container(
          width: 200, 
          height: 200, 
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          child: GestureDetector(
            onPanDown: _onPanDown,
            onPanUpdate: _onPanUpdate,
            onPanCancel: _onPanCancel,
            onPanEnd: (DragEndDetails details) async {
              await _onPanEnd(details);
              await imageProvider.updatePaletteGenerator(_region);
            },
            child: Stack(children: <Widget>[
              imageProvider.storedImageInitialised
              ? Image(
                key: imageKey,
                image: FileImage(File(imageProvider.storedImagePath)),
                width: 200,
                height: 200,
                fit: BoxFit.cover
              )
              : Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
              ),
              // This is the selection rectangle.
              Positioned.fromRect(
                  rect: _dragRegion ?? _region ?? Rect.zero,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          width: 1.0,
                          color: imageProvider.storedImageInitialised 
                            ? Colors.grey
                            : Colors.transparent,
                          style: BorderStyle.solid,
                        )),
                  )),
            ]),
          ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text("Take Photo"),
              onPressed: () => {
                imageProvider.getPictureFrom("camera")
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.only(left: 20, right: 20)
                )
              )
            ),
            SizedBox(height: 20.0),
            TextButton.icon(
              icon: Icon(Icons.image),
              label: Text("Choose Photo"),
              onPressed: () => {
                imageProvider.getPictureFrom("gallery")
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.only(left: 20, right: 20)
                )
              )
            )
          ]
        )
      ],
    );
  }
}