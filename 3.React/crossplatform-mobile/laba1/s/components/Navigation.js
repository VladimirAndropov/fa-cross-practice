import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { NavigationContainer } from '@react-navigation/native';
import ProductList from './ProductList';

const Tab = createBottomTabNavigator();

const Navigation = () => {
  return (
    <NavigationContainer>
      <Tab.Navigator>
        <Tab.Screen name="Новинки" component={ProductList} />
        <Tab.Screen name="Популярное" component={ProductList} />
        <Tab.Screen name="Сеты и пары" component={ProductList} />
      </Tab.Navigator>
    </NavigationContainer>
  );
};

export default Navigation;
