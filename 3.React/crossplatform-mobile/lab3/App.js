import { StatusBar } from 'expo-status-bar';
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
          image: <Image style={{ width: 300, height: 300 }} source={require('./img/finbeer_logo.png')} />,
          title: 'Просто попробуй и жить станет легче!',
          subtitle: '',
        },
        {
          backgroundColor: '#fff',
          titleStyles: {
            color: '#3E6266',
          },
          image: <Image style={{ width: 300, height: 300 }} source={require('./img/for_fu.png')} />,
          title: 'Мы - твой билет в лучшую жизнь!',
          subtitle: '',
        },
        {
          backgroundColor: '#fff',
          titleStyles: {
            color: '#3E6266',
          },
          image: <Image source={require('./img/happy_fu.png')} />,
          title: 'Делаем  студентов всей Финашки счастливыми!',
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
