import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import Registration from './screens/Registration';
import Login from './screens/Login';

const Stack = createStackNavigator();

const Navigation = () => {
  return (
    <Stack.Navigator initialRouteName="Registration">
      <Stack.Screen name="Registration" component={Registration} />
      <Stack.Screen name="Login" component={Login} />
    </Stack.Navigator>
  );
};

export default Navigation;