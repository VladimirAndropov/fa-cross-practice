# Распознавание с камеры c flutter

## Сначала создаем приложение и добавляем камеру



    flutter create cameratest
    cd ca*
    flutter pub add camera

    flutter pub get


Кидаем код из примера
https://github.com/flutter/plugins/tree/main/packages/camera/camera#example
в
lib/main.dart

lib/main.dart - это файл с кодом приложения
pubspec.yaml - это файл с настройками плагинов

плагины подключаются командой

    flutter pub add 


Чтобы запустить, набираем

    flutter run

## Предварительные ласки

Работаем Tensorflow lite он же LiteRT 

Чтобы его установить надо пройти квест


## Квест по установке LiteRT


Нам нужно ввести всего две команды, но для этого надо собрать предварительные пакеты

    cmake /opt/tensorflow-2.12.0/tensorflow/lite/c
    cmake --build . -j4



Смотрим здесь на Английском
https://ai.google.dev/edge/litert/build/cmake

https://github.com/tensorflow/tensorflow/tree/v2.12.1

https://ubuntuhandbook.org/index.php/2023/09/how-to-install-clang-17-or-16-in-ubuntu-22-04-20-04/

https://github.com/bazelbuild/bazel/releases?q=5.3.0&expanded=true


Или повторяем за мной

## установка для Линукса

![](img/1.png)
![](img/2.png)
![](img/3.png)
![](img/4.png)
![](img/5.png)

![](img/6.png)
![](img/7.png)
![](img/8.png)
![](img/9.png)
![](img/10.png)
![](img/11.png)
![](img/12.png)
![](img/13.png)
![](img/14.png)
![](img/15.png)

As a second step, the library needs to be added to your application's project. This is a simple procedure

1. Create a folder called `blobs` in the top level of your project
2. Copy the `libtensorflowlite_c-linux.so` to this folder
3. Append following lines to your `linux/CMakeLists.txt`

``` Make
...

# get tf lite binaries
install(
  FILES ${PROJECT_BUILD_DIR}/../blobs/libtensorflowlite_c-linux.so
  DESTINATION ${INSTALL_BUNDLE_DATA_DIR}/../blobs/
)
```

### Windows

For Windows a TensorFlow Lite dynamic library needs to be added to the project manually.
For this, first a `.dll` needs to be built. You can follow the [Bazel build guide](https://www.tensorflow.org/lite/guide/build_arm) or the [CMake build guide](https://www.tensorflow.org/lite/guide/build_cmake) to build the libraries.

As a second step, the library needs to be added to your application's project. This is a simple procedure

1. Create a folder called `blobs` in the top level of your project
2. Copy the `libtensorflowlite_c-win.dll` to this folder
3. Append following lines to your `windows/CMakeLists.txt`

``` Make
...

# get tf lite binaries
install(
  FILES ${PROJECT_BUILD_DIR}/../blobs/libtensorflowlite_c-win.dll 
  DESTINATION ${INSTALL_BUNDLE_DATA_DIR}/../blobs/
)
```

## Ура! Мы запускаем примеры 

Если в папке 3.flutter

 видим ссылку flutter-tflite, то выполняем 


```
git submodule update --init --recursive 3.flutter/flutter-tflite
```

Если ссылки нет, то

```
git submodule add https://github.com/tensorflow/flutter-tflite
```


Заходим в 3.flutter/flutter-tflite-main/example/image_classification_mobilenet

добавляем в blobs скомпилированный

    libtensorflowlite_c-linux.so

## Самостоятельная

Дальше читаем здесь и выполняем 4 страницы
https://www.kodeco.com/37077010-tensorflow-lite-tutorial-for-flutter-image-classification
