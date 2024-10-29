import React, { useEffect, useRef, useState } from 'react';
import { View, Text, StyleSheet, Animated, TouchableOpacity } from 'react-native';
import Slider from './components/Slider';  // Импортируем слайдер
import LaunchScreen from './components/LaunchScreen';  // Импортируем лаунч-скрин

export default function App() {
  const [isReady, setIsReady] = useState(false);  // Состояние готовности (показ лаунч-скрина)

  useEffect(() => {
    // Запускаем анимацию лаунч-скрина на 3 секунды
    setTimeout(() => setIsReady(true), 3000);
  }, []);

  if (!isReady) return <LaunchScreen />;  // Показываем лаунч-скрин

  return (
    <View style={styles.container}>
      <Slider />  
      <AnimatedButton />  
    </View>
  );
}

// Анимированная кнопка
const AnimatedButton = () => {
  const scaleAnim = useRef(new Animated.Value(1)).current;

  const onPressIn = () => {
    Animated.spring(scaleAnim, {
      toValue: 0.8,  // Сжатие кнопки
      useNativeDriver: true,
    }).start();
  };

  const onPressOut = () => {
    Animated.spring(scaleAnim, {
      toValue: 1,  // Возврат к исходному размеру
      useNativeDriver: true,
    }).start();
  };

  return (
    <TouchableOpacity onPressIn={onPressIn} onPressOut={onPressOut} style={styles.buttonContainer}>
      <Animated.View style={[styles.button, { transform: [{ scale: scaleAnim }] }]}>
        <Text style={styles.buttonText}>Нажми меня</Text>
      </Animated.View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#fff', justifyContent: 'center' },
  buttonContainer: { alignItems: 'center', marginTop: 20 },
  button: {
    backgroundColor: '#4CAF50',
    padding: 15,
    borderRadius: 10,
  },
  buttonText: { color: '#fff', fontSize: 18 },
});
