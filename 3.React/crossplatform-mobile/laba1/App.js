import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import StartScreen from './screens/start';
import SecondScreen from './screens/second';
import ThirdScreen from './screens/Third';

const Stack = createNativeStackNavigator();


export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          name="Home"
          component={StartScreen}
          options={{ title: 'Первый экран' }}
        />

        <Stack.Screen name="Second" 
        component={SecondScreen} 
        options={{ title: 'Второй экран' }}/>

        <Stack.Screen name="Third" 
        component={ThirdScreen} 
        options={{ title: 'Третий экран' }}/>
      </Stack.Navigator>
    </NavigationContainer>
    // <View style={styles.container}>
    //   <Text>Open up App.js to start working on your app!</Text>
    //   <StatusBar style="auto" />
    // </View>
  );
}