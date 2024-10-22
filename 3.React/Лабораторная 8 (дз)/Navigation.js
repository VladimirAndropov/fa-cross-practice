import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import Registration from './Screens/Registration';
import Login from './Screens/Login';
import WelcomeScreen from './Screens/WelcomeScreen';

const Stack = createStackNavigator();

const Navigation = () => {
  return (
    <Stack.Navigator initialRouteName="Registration">
      <Stack.Screen name="Registration" component={Registration} />
      <Stack.Screen name="Login" component={Login} />
      <Stack.Screen name="Welcome" component={WelcomeScreen} />
    </Stack.Navigator>
  );
};

export default Navigation;