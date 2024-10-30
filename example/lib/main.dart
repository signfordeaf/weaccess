import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weaccess/weaccess.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await WeAccess.init(apiKey: dotenv.env['WEACCESS_API_KEY'] ?? '');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeAccess WePhoto Demo Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'WePhoto Image Description'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _imageList = [
    'https://media.istockphoto.com/id/1205214235/photo/path-through-sunlit-forest.jpg?s=612x612&w=0&k=20&c=-AS1aTz85kcZ2X7E8n2iFlm6dsdIMyWGWrSDQ1o-f_0=',
    'https://media.istockphoto.com/id/148421596/photo/traffic-jam-with-rows-of-cars.jpg?s=612x612&w=0&k=20&c=GeldRtTNo_vMfE7aHxhQY0QoV2DMyzi4LqTOLZL5svc=',
    'https://img.freepik.com/free-photo/new-york-city_649448-1679.jpg',
  ];

  final WePhotoController _wePhotoController = WePhotoController();
  final WePhotoController _wePhotoController2 = WePhotoController();
  final WePhotoController _wePhotoController3 = WePhotoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _wePhotoImage(_imageList[0], _wePhotoController),
              /* _wePhotoImage(_imageList[1], _wePhotoController2),
              _wePhotoImage(_imageList[2], _wePhotoController3), */
            ],
          ),
        ),
      ),
    );
  }

  Column _wePhotoImage(String imageSource, WePhotoController controller) {
    return Column(
      children: [
        /* Container(
          margin: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: WePhoto(
              controller: controller,
              image: NetworkImage(
                imageSource,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 400,
          child: Text(
            'Semantics Label:\n ${controller.description}',
          ),
        ), */

        Container(
          margin: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: WePhoto(
              controller: controller,
              image: const AssetImage(
                'assets/image.jpg',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
