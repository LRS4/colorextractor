import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:math' as math;

/// A widget that draws the swatches for the [PaletteGenerator] it is given,
/// and shows the selected target colors.
class PaletteSwatches extends StatelessWidget {
  /// Create a Palette swatch.
  ///
  /// The [generator] is optional. If it is null, then the display will
  /// just be an empty container.
  PaletteSwatches({Key? key, this.generator}) : super(key: key);

  /// The [PaletteGenerator] that contains all of the swatches that we're going
  /// to display.
  final PaletteGenerator? generator;

  String _rgbToHex(Color? color) {
    if (color == null) {
      return "None";
    }

    return "#" + color.value.toRadixString(16).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> swatches = <Widget>[];
    final PaletteGenerator? paletteGen = generator;
    if (paletteGen == null || paletteGen.colors.isEmpty) {
      return Container();
    }
    for (final Color color in paletteGen.colors) {
      swatches.add(
        PaletteSwatch(
          label: _rgbToHex(color),
          color: color
        )
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("All Colors"),
        SizedBox(height: 10),
        Wrap(
          children: swatches,
        ),
        Container(height: 30.0),
        Text("Dominant, Vibrant and Muted Colors"),
        SizedBox(height: 10),
        Wrap(
          children: [
            PaletteSwatch(
              label: _rgbToHex(paletteGen.dominantColor?.color),
              color: paletteGen.dominantColor?.color
            ),
            PaletteSwatch(
              label: _rgbToHex(paletteGen.lightVibrantColor?.color),
              color: paletteGen.lightVibrantColor?.color
            ),
            PaletteSwatch(
              label: _rgbToHex(paletteGen.vibrantColor?.color),
              color: paletteGen.vibrantColor?.color
            ),
            PaletteSwatch(
              label: _rgbToHex(paletteGen.darkVibrantColor?.color),
              color: paletteGen.darkVibrantColor?.color
              ),
            PaletteSwatch(
              label: _rgbToHex(paletteGen.lightMutedColor?.color),
              color: paletteGen.lightMutedColor?.color
            ),
            PaletteSwatch(
              label: _rgbToHex(paletteGen.mutedColor?.color),
              color: paletteGen.mutedColor?.color
            ),
            PaletteSwatch(
              label: _rgbToHex(paletteGen.darkMutedColor?.color),
              color: paletteGen.darkMutedColor?.color
            )
          ]
        )
      ],
    );
  }
}

/// A small square of color with an optional label.
@immutable
class PaletteSwatch extends StatelessWidget {
  /// Creates a PaletteSwatch.
  ///
  /// If the [paletteColor] has property `isTargetColorFound` as `false`,
  /// then the swatch will show a placeholder instead, to indicate
  /// that there is no color.
  const PaletteSwatch({
    Key? key,
    this.color,
    this.label,
  }) : super(key: key);

  /// The color of the swatch.
  final Color? color;

  /// The optional label to display next to the swatch.
  final String? label;

  @override
  Widget build(BuildContext context) {
    // Compute the "distance" of the color swatch and the background color
    // so that we can put a border around those color swatches that are too
    // close to the background's saturation and lightness. We ignore hue for
    // the comparison.
    const Color _kBackgroundColor = Color(0xffa0a0a0);
    const Color _kPlaceholderColor = Color(0x80404040);
    final HSLColor hslColor = HSLColor.fromColor(color ?? Colors.transparent);
    final HSLColor backgroundAsHsl = HSLColor.fromColor(_kBackgroundColor);
    final double colorDistance = math.sqrt(
        math.pow(hslColor.saturation - backgroundAsHsl.saturation, 2.0) +
            math.pow(hslColor.lightness - backgroundAsHsl.lightness, 2.0));

    Widget swatch = Padding(
      padding: const EdgeInsets.all(2.0),
      child: color == null
          ? const Placeholder(
              fallbackWidth: 34.0,
              fallbackHeight: 20.0,
              color: Color(0xff404040),
              strokeWidth: 2.0,
            )
          : Container(
              decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    width: 1.0,
                    color: _kPlaceholderColor,
                    style: colorDistance < 0.2
                        ? BorderStyle.solid
                        : BorderStyle.none,
                  )),
              width: 34.0,
              height: 20.0,
            ),
    );

    if (label != null) {
      swatch = ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 130.0, minWidth: 130.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            swatch,
            Container(width: 5.0),
            Text(label!),
          ],
        ),
      );
    }
    return swatch;
  }
}
