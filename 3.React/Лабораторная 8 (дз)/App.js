import Toast from 'react-native-toast-message';
import { NavigationContainer } from '@react-navigation/native';
import Navigation from './Navigation';
import { Component } from 'react';
import * as Font from 'expo-font';
import AppLoading from 'expo-app-loading';

export default class App extends Component {
  state = {
    isFontLoaded: false,
  };

  async componentDidMount() {
    await Font.loadAsync({
      'SemiBold': require('./assets/fonts/Roboto-Bold.ttf'),
      'Medium': require('./assets/fonts/Roboto-Medium.ttf'),
      'Regular': require('./assets/fonts/Roboto-Regular.ttf'),
    });
    this.setState({ isFontLoaded: true });
  }

  render() {
    if (!this.state.isFontLoaded) {
      return <AppLoading />;
    }

    return (
      <NavigationContainer>
        <Navigation />
        <Toast />
    </NavigationContainer>
    );
  }
}