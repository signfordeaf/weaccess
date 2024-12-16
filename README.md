# WeAccess WePhoto

## 🛠️ Install
Write to the terminal from the project directory.
```dart
flutter pub add weaccess
```
## 🗝️ Activation
```dart
void main() async {
  ...
  await WeAccess.init(apiKey: 'YOUR_API_KEY');
  runApp(const App());
}
```

## 🧑🏻💻 Usage
```dart
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
