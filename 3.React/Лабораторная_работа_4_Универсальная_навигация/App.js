import React from 'react';
import { Text, View, Button, SafeAreaView, StyleSheet } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createDrawerNavigator } from '@react-navigation/drawer';

function StartScreen({ navigation }) {
  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>Это первая страница</Text>
      <Button
        title="Перейти на второй экран"
        onPress={() => navigation.navigate('Вторая страница')}
      />
    </SafeAreaView>
  );
}

function SecondScreen({ navigation }) {
  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>Это вторая страница</Text>
      <Button title="Назад" onPress={() => navigation.goBack()} />
      <View style={styles.buttonSpacing} />
      <Button
        title="Перейти на третий экран"
        onPress={() => navigation.navigate('Третья страница')}
      />
    </SafeAreaView>
  );
}

function ThirdScreen({ navigation }) {
  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>Это страница 3</Text>
      <Button
        title="Назад к первому экрану"
        onPress={() => navigation.navigate('Первая страница')}
      />
    </SafeAreaView>
  );
}

const Drawer = createDrawerNavigator();

function AppDrawerNavigator() {
  return (
    <Drawer.Navigator initialRouteName="Start">
      <Drawer.Screen name="Первая страница" component={StartScreen} />
      <Drawer.Screen name="Вторая страница" component={SecondScreen} />
      <Drawer.Screen name="Третья страница" component={ThirdScreen} />
    </Drawer.Navigator>
  );
}

export default function App() {
  return (
    <NavigationContainer>
      <AppDrawerNavigator />
    </NavigationContainer>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    padding: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  buttonSpacing: {
    height: 15,
  },
});
