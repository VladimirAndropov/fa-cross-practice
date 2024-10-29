import React, { useState } from 'react';
import { View, Text, TextInput, Alert, StyleSheet, Image, TouchableOpacity } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';

export default function Login({ navigation }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = () => {
    Alert.alert('Авторизация прошла успешно!');
  };

  return (
    <View style={styles.container}>
      <Image source={require('../assets/images/star.png')} style={styles.image} />
      <Text style={styles.header}>Авторизация</Text>
      <Text style={styles.subHeader}>
        Введите логин и пароль, который создавали ранее при регистрации.
      </Text>
      <View style={styles.inputContainer}>
        <Icon name="envelope" size={20} color="#8B0000" style={styles.icon} />
        <TextInput
          style={styles.input}
          placeholder="Email"
          value={email}
          onChangeText={setEmail}
        />
      </View>
      <View style={styles.inputContainer}>
        <Icon name="lock" size={20} color="#8B0000" style={styles.icon} />
        <TextInput
          style={styles.input}
          placeholder="Пароль"
          value={password}
          onChangeText={setPassword}
          secureTextEntry
        />
      </View>
      <TouchableOpacity style={styles.button} onPress={handleLogin}>
        <Text style={styles.buttonText}>Войти</Text>
      </TouchableOpacity>
      <TouchableOpacity onPress={() => navigation.navigate('Register')}>
        <Text style={styles.link}>Зарегистрироваться</Text>
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
    borderColor: '#8B0000',
    borderWidth: 1,
    borderRadius: 25,  // Закругленные поля
    marginBottom: 10,
    paddingHorizontal: 15,
    height: 50,
  },
  icon: { marginRight: 10 },
  input: { flex: 1, height: 40 },
  button: { backgroundColor: '#8B0000', padding: 12, borderRadius: 25, width: '100%', marginTop: 10 },
  buttonText: { color: '#fff', textAlign: 'center', fontSize: 18 },
  link: { marginTop: 10, color: '#006400', fontSize: 16 },
});
