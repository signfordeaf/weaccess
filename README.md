<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->


# SignForDeaf Mobile Sign Language

## 🧑🏻💻 Usage

###  📄main.dart
```dart
void main() async {
 
  await WeAccess.init(apiKey: 'YOUR_API_KEY');

  runApp(const App());
}


class MyPage extends StatelessWidget {
    const MyPage({super.key});

    final WePhotoController _wePhotoController = WePhotoController();

    @override
    Widget build(BuildContext context) {
        return Column(
        children: [
           WePhoto(
            controller: controller,
            image: NetworkImage(
                'image_url',
            ),
        ),
      ],
    );
  }
}
```
