import 'package:flutter/material.dart';
import 'package:flutter_clicker/resources/resources.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кликер',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Капибара Кликер'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: CapibarasRow(),
    );
  }
}

class CapibarasRow extends StatelessWidget {
  const CapibarasRow({super.key});

  static const List<String> images = [
    Images.capybaraBlueSuit,
    Images.capybaraWithRedScarf,
    Images.cuteCapybaraCloth,
  ];

  static const double separatorWidth = 10;

  double getCapibaraWidth(double screenWidth) {
    return (screenWidth - separatorWidth * (images.length - 1)) / images.length;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) => CapibaraWidget(
        imagePath: images[index],
        width: getCapibaraWidth(
          MediaQuery.of(context).size.width,
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(
        width: separatorWidth,
      ),
    );
  }
}

class CapibaraWidget extends StatefulWidget {
  const CapibaraWidget(
      {super.key, required this.imagePath, required this.width});

  final String imagePath;
  final double width;

  @override
  State<StatefulWidget> createState() => _CapibaraWidgetState();
}

class _CapibaraWidgetState extends State<CapibaraWidget> {
  int _counter = 0;
  double widthCoeff = 1;

  void onTap() {
    setState(() {
      _counter += 1;
    });
  }

  void onTapDown(TapDownDetails? details) {
    setState(() => widthCoeff = 1.2);
  }

  void onTapUp(TapUpDetails? details) {
    setState(() => widthCoeff = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          onTap: onTap,
          onTapUp: onTapUp,
          onTapDown: onTapDown,
          child: Image.asset(
            widget.imagePath,
            width: widget.width * widthCoeff,
          ),
        ),
        Text('$_counter'),
      ],
    );
  }
}
