import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View, Button, TouchableOpacity } from 'react-native';
import { Accelerometer } from 'expo-sensors';
import * as WebBrowser from 'expo-web-browser';
import { Video } from 'expo-av';
import { Camera,CameraView } from 'expo-camera';

const App = () => {
  const [data, setData] = useState({});
  const [subscription, setSubscription] = useState(null);
  const [hasPermission, setHasPermission] = useState(null);
  const [cameraVisible, setCameraVisible] = useState(false);

  // Акселерометр
  useEffect(() => {
    Accelerometer.setUpdateInterval(500);
  }, []);

  const subscribe = () => {
    setSubscription(
      Accelerometer.addListener(accelerometerData => {
        setData(accelerometerData);
      })
    );
  };

  const unsubscribe = () => {
    subscription && subscription.remove();
    setSubscription(null);
  };

  const toggleAccelerometer = () => {
    subscription ? unsubscribe() : subscribe();
  };

  const { x, y, z } = data;

  // Встроенный браузер
  const openWebBrowser = async () => {
    await WebBrowser.openBrowserAsync('https://docs.expo.dev');
  };

  // Камера
  useEffect(() => {
    (async () => {
      
      const { status } = await Camera.requestCameraPermissionsAsync();
      setHasPermission(status === 'granted');
    })();
  }, []);

  if (hasPermission === null) {
    return <View />;
  }

  if (hasPermission === false) {
    return <Text>Нет доступа к камере</Text>;
  }

  return (
    <View style={styles.container}>
      {/* Мониторинг активности */}
      <View style={styles.section}>
        <Text style={styles.title}>Акселерометр</Text>
        <Text style={styles.text}>x: {x ? x.toFixed(2) : '0.00'}</Text>
        <Text style={styles.text}>y: {y ? y.toFixed(2) : '0.00'}</Text>
        <Text style={styles.text}>z: {z ? z.toFixed(2) : '0.00'}</Text>
        <Button onPress={toggleAccelerometer} title={subscription ? 'Стоп' : 'Старт'} />
      </View>

      {/* Открытие сайта */}
      <View style={styles.section}>
        <Button title="Открыть сайт" onPress={openWebBrowser} />
      </View>

      {/* Видео */}
      <View style={styles.section}>
        <Text style={styles.title}>Видео</Text>
        <Video
          source={{ uri: 'https://cs15.pikabu.ru/video/2024/12/16/1734367788295711398_5b2eb6b0_720x1280.av1.mp4' }}
          rate={1.0}
          volume={1.0}
          isMuted={false}
          resizeMode="cover"
          shouldPlay
          style={styles.video}
        />
      </View>

      {/* Камера */}
      <View style={styles.section}>
        <Button title="Показать камеру" onPress={() => setCameraVisible(!cameraVisible)} />
        {cameraVisible && (
          <View style={styles.cameraContainer}>
            <CameraView style={styles.camera}>
              <TouchableOpacity
              style={styles.cameraButton}
              onPress={() => setCameraVisible(false)}>
                <Text style={styles.cameraButtonText}>Закрыть</Text>
              </TouchableOpacity>
            </CameraView>
          </View>
)}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  section: {
    marginVertical: 20,
    alignItems: 'center',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  text: {
    fontSize: 16,
    marginVertical: 5,
  },
  video: {
    width: 300,
    height: 200,
  },
  camera: {
    width: 300,
    height: 400,
    marginTop: 10,
  },
  cameraButton: {
    position: 'absolute',
    bottom: 20,
    alignSelf: 'center',
    backgroundColor: '#000',
    padding: 10,
    borderRadius: 5,
  },
  cameraButtonText: {
    color: '#fff',
    fontSize: 16,
  },
});

export default App;
