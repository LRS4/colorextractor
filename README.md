# Color Palette Extractor

A Flutter mobile application to extract colors from a photo. The photo can be taken with the camera or selected from the device photo gallery.

## Building for production and release

First increment the major or minor version number in the `pubspec.yaml` file.

To generate icon files run:

```
flutter pub run flutter_launcher_icons:main
```

To generate native splash screens run:

```
flutter pub run flutter_native_splash:create
```

To build the app:

```
flutter build appbundle
```
