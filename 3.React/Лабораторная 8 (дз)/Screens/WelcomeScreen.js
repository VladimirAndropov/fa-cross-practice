import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const WelcomeScreen = ({ route }) => {
  const { email } = route.params; // Получаем email из параметров навигации

  return (
    <View style={styles.container}>
      <Text style={styles.welcomeText}>Добро пожаловать, {email}!</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 16,
  },
  welcomeText: {
    fontSize: 24,
    fontWeight: 'bold',
  },
});

export default WelcomeScreen;