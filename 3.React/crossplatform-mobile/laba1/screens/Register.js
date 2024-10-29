import React, { useState } from 'react';
import { View, Text, TextInput, Alert, StyleSheet, Image, TouchableOpacity } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';

export default function Register({ navigation }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');

  const handleRegister = () => {
    if (password !== confirmPassword) {
      Alert.alert('Ошибка', 'Пароли не совпадают.');
      return;
    }
    Alert.alert('Регистрация прошла успешно!');
  };

  return (
    <View style={styles.container}>
      <Image source={require('../assets/images/star.png')} style={styles.image} />
      <Text style={styles.header}>Регистрация</Text>
      <Text style={styles.subHeader}>
        Введите, пожалуйста, свои персональные данные для дальнейшей персонализации.
      </Text>
      <View style={styles.inputContainer}>
        <Icon name="envelope" size={20} color="#006400" style={styles.icon} />
        <TextInput
          style={styles.input}
          placeholder="Email"
          value={email}
          onChangeText={setEmail}
        />
      </View>
      <View style={styles.inputContainer}>
        <Icon name="lock" size={20} color="#006400" style={styles.icon} />
        <TextInput
          style={styles.input}
          placeholder="Пароль"
          value={password}
          onChangeText={setPassword}
          secureTextEntry
        />
      </View>
      <View style={styles.inputContainer}>
        <Icon name="lock" size={20} color="#006400" style={styles.icon} />
        <TextInput
          style={styles.input}
          placeholder="Пароль еще раз"
          value={confirmPassword}
          onChangeText={setConfirmPassword}
          secureTextEntry
        />
      </View>
      <TouchableOpacity style={styles.button} onPress={handleRegister}>
        <Text style={styles.buttonText}>Зарегистрироваться</Text>
      </TouchableOpacity>
      <TouchableOpacity onPress={() => navigation.navigate('Login')}>
        <Text style={styles.link}>Уже есть аккаунт? Войти</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#fff', alignItems: 'center', justifyContent: 'center', padding: 20 },
  image: { width: 300, height: 300, marginBottom: 20 },  // Увеличили звезду
  header: { fontSize: 28, fontWeight: 'bold', marginBottom: 10 },
  subHeader: { textAlign: 'center', color: '#8e8e8e', marginBottom: 20 },
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderColor: '#006400',
    borderWidth: 1,
    borderRadius: 25,  // Закругленные поля
    marginBottom: 10,
    paddingHorizontal: 15,
    height: 50,
  },
  icon: { marginRight: 10 },
  input: { flex: 1, height: 40 },
  button: { backgroundColor: '#006400', padding: 12, borderRadius: 25, width: '100%', marginTop: 10 },
  buttonText: { color: '#fff', textAlign: 'center', fontSize: 18 },
  link: { marginTop: 10, color: '#8B0000', fontSize: 16 },
});
