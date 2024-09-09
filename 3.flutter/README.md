# Распознавание с камеры c flutter

## Сначала создаем приложение и добавляем камеру



    flutter create cameratest
    cd ca*
    flutter pub add camera

    flutter pub get


Кидаем код из примера
https://github.com/flutter/plugins/tree/main/packages/camera/camera#example

lib/main.dart

    flutter run

## Потом добавляем распознавание

через Tensorflow lite

Читаем здесь
https://www.kodeco.com/37077010-tensorflow-lite-tutorial-for-flutter-image-classification

Заходим в starter

добавляем

     tflite_flutter: ^0.9.0
    tflite_flutter_helper: ^0.3.1