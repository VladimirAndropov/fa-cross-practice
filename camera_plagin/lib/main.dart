import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const CameraApp());
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Обрабатываем ошибку, если доступ к камере был отклонен.
            print('Доступ к камере отклонен');
            break;
          default:
            // Обрабатываем другие ошибки.
            print('Ошибка камеры: $e');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Загрузка камеры'),
        ),
        body: const Center(
          child:
              CircularProgressIndicator(), // Показываем индикатор загрузки, пока камера не инициализируется
        ),
      );
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Предпросмотр камеры'),
        ),
        body: CameraPreview(
            controller), // Показываем камеру, когда инициализация завершена
      ),
    );
  }
}
