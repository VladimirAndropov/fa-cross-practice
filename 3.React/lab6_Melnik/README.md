import React from 'react';
import { Text, View, TextInput, Image, TouchableOpacity, StyleSheet } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

export default class Login extends React.Component {
  state = {
    email: '',
    password: '',
    storedUser: null,
  };

  componentDidMount = async () => {
    // Загружаем данные пользователя из AsyncStorage
    const storedUser = await AsyncStorage.getItem('user');
    if (storedUser) {
      this.setState({ storedUser: JSON.parse(storedUser) });
    }
  };

  handleLogin = () => {
    const { email, password, storedUser } = this.state;

    if (storedUser && email === storedUser.email && password === storedUser.password) {
      alert('Вход выполнен успешно!');
      // Вы можете перенаправить пользователя на домашний экран или другой экран
    } else {
      alert('Неправильный логин или пароль');
    }
  };

  render() {
    return (
      <View style={styles.container}>
        <Image source={require('../images/image.png')} style={styles.image} />
        <Text style={styles.title}>Авторизация</Text>
        <TextInput
          placeholder="Email"
          style={styles.input}
          value={this.state.email}
          onChangeText={(text) => this.setState({ email: text })}
        />
        <TextInput
          placeholder="Пароль"
          style={styles.input}
          secureTextEntry={true}
          value={this.state.password}
          onChangeText={(text) => this.setState({ password: text })}
        />
        
        <TouchableOpacity onPress={this.handleLogin} style={styles.button}>
          <Text style={styles.buttonText}>Войти</Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => this.props.navigation.navigate('Register')}>
          <Text style={styles.registerText}>Зарегистрироваться</Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#fff',
    height: '100%',
    paddingHorizontal: 20,
    justifyContent: 'center',
  },
  image: {
    width: '100%',
    height: '30%',
    marginBottom: 20,
  },
  title: {
    fontSize: 26,
    fontFamily: 'SemiBold',
    textAlign: 'center',
    color: '#333',
  },
  input: {
    marginHorizontal: 55,
    borderWidth: 2,
    marginTop: 50,
    paddingHorizontal: 10,
    borderColor: '#00716F',
    borderRadius: 23,
    paddingVertical: 2,
  },
  button: {
    backgroundColor: '#00716F',
    alignItems: 'center',
    justifyContent: 'center',
    marginHorizontal: 55,
    marginTop: 30,
    borderRadius: 23,
    paddingVertical: 10,
  },
  buttonText: {
    color: 'white',
    fontSize: 18,
    fontFamily: 'SemiBold',
  },
  registerText: {
    textAlign: 'center',
    color: '#00716F',
    marginTop: 20,
    fontSize: 16,
    fontFamily: 'Regular',
  },
});
