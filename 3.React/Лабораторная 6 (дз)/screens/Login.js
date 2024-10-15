import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, TouchableOpacity, Image } from 'react-native';
import Toast from 'react-native-toast-message';

const Login = ({ navigation }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = () => {
    // Логика входа
    console.log("Logged in", email);

    // Показываем всплывающее сообщение об успешной авторизации
    Toast.show({
      type: 'success',
      text1: 'Авторизация успешна!',
      text2: `Добро пожаловать обратно!`
    });
  };

  return (
    <View style={styles.container}>
      <Image
      source={'https://ouch-cdn2.icons8.com/-ShWh9LwoNcq_qo4m1haH2nwTB1eYFLmodTQkSZSxqU/rs:fit:456:456/extend:false/wm:1:re:0:0:0.8/wmid:ouch2/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNzk4/L2E2OGRjZGIyLTBh/ZTQtNDQyMS05MWZm/LTE0YmUxMDNlNGE4/NC5wbmc.png'}
      style={styles.image} />
      <Text style={styles.title}>Вход</Text>
      <TextInput
        style={styles.input}
        placeholder="Почта"
        value={email}
        onChangeText={setEmail}
      />
      <TextInput
        style={styles.input}
        placeholder="Пароль"
        value={password}
        onChangeText={setPassword}
        secureTextEntry
      />
      <TouchableOpacity style={styles.button} onPress={handleLogin}>
        <Text style={styles.buttonText}>Войти</Text>
      </TouchableOpacity>
      <TouchableOpacity onPress={() => navigation.navigate('Registration')}>
        <Text style={styles.textButton}>Нет аккаунта? Зарегистрироваться</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    padding: 16,
  },
  title: {
    fontSize: 24,
    marginBottom: 16,
    fontFamily: 'Roboto-Bold',
    textAlign: 'center',
  },
  input: {
    height: 40,
    borderColor: 'green',
    borderWidth: 2,
    borderRadius: 25,
    marginBottom: 12,
    paddingHorizontal: 15,
    backgroundColor: '#F0FFF0',
  },
  button: {
    backgroundColor: 'green',
    paddingVertical: 12,
    borderRadius: 25,
    marginBottom: 16,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
  textButton: {
    fontSize: 16,
    color: 'green',
    textAlign: 'center',
  },
  image: {
    width: 100,
    height: 100,
    alignSelf: 'center',
    marginBottom: 20,
  },
});

export default Login;
