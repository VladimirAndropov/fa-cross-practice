//import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, Image } from 'react-native';
import Onboarding from 'react-native-onboarding-swiper';


export default function App() {
  return (
    <Onboarding
      pages={[
        {
          backgroundColor: '#fff',
          titleStyles: {
            color: '#3E6266',
          },
          image: <Image style={{ width: 300, height: 300 }} source={require('./assets/img/cat3.jpg')} />,
          title: 'Первая картинка',
          subtitle: '',
        },
        {
          backgroundColor: '#fff',
          titleStyles: {
            color: '#3E6266',
          },
          image: <Image style={{ width: 300, height: 300 }} source={require('./assets/img/cat4.jpg')} />,
          title: 'Вторая картинка',
          subtitle: '',
        },
        {
          backgroundColor: '#fff',
          titleStyles: {
            color: '#3E6266',
          },
          image: <Image style={{ width: 300, height: 300 }} source={require('./assets/img/cat5.jpg')} />,
          title: 'Третья картинка',
          subtitle: '',
        },
      ]}
    />
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
