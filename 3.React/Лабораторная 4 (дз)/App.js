import 'react-native-gesture-handler';
import { Button, View, Text, Image, ScrollView, StyleSheet } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createDrawerNavigator } from '@react-navigation/drawer';
import { createStackNavigator } from '@react-navigation/stack';
import { SafeAreaProvider } from 'react-native-safe-area-context';

const movies = [
  {
    title: 'The Fellowship of the Ring',
    preview: 'https://upload.wikimedia.org/wikipedia/en/f/fb/Lord_Rings_Fellowship_Ring.jpg',
    shortDescription: 'The first chapter in the epic Lord of the Rings trilogy.',
    fullDescription: 'The young hobbit Frodo Baggins is tasked with the monumental journey to destroy the One Ring in the fires of Mount Doom. Accompanied by the Fellowship of the Ring, they face numerous trials, dangers, and treachery across Middle-earth.',
  },
  {
    title: 'The Two Towers',
    preview: 'https://upload.wikimedia.org/wikipedia/en/a/a1/Lord_Rings_Two_Towers.jpg',
    shortDescription: 'The second chapter of the Lord of the Rings saga.',
    fullDescription: 'The Fellowship is broken, but the fight against Sauron and his allies continues. Frodo and Sam continue their perilous journey towards Mount Doom, while Aragorn, Legolas, and Gimli battle Saruman’s forces and prepare for the coming war.',
  },
  {
    title: 'The Return of the King',
    preview: 'https://upload.wikimedia.org/wikipedia/en/4/48/Lord_Rings_Return_King.jpg',
    shortDescription: 'The final chapter of the Lord of the Rings trilogy.',
    fullDescription: 'As Sauron’s armies close in, Frodo and Sam edge ever closer to Mount Doom. Aragorn must claim his birthright as King of Gondor and rally the forces of Middle-earth for a climactic battle against the Dark Lord.',
  },
];

const Start = ({ navigation }) => (
  <View style={styles.container}>
    <Text style={styles.title}>The Lord of the Rings Trilogy</Text>
    <Text style={styles.description}>
      An epic fantasy adventure film series based on the novels by J.R.R. Tolkien.
    </Text>
    <Button title="Перейти к первому фильму" onPress={() => navigation.navigate('Second')} />
  </View>
);

const Second = ({ navigation }) => (
  <ScrollView contentContainerStyle={styles.container}>
    <Text style={styles.title}>{movies[0].title}</Text>
    <Image source={{ uri: movies[0].preview }} style={styles.image} />
    <Text style={styles.description}>{movies[0].shortDescription}</Text>
    <Text style={styles.description}>{movies[0].fullDescription}</Text>
    <Button title="Назад" onPress={() => navigation.goBack()} />
    <Button title="Далее" onPress={() => navigation.navigate('Third')} />
  </ScrollView>
);

const Third = ({ navigation }) => (
  <ScrollView contentContainerStyle={styles.container}>
    <Text style={styles.title}>{movies[1].title}</Text>
    <Image source={{ uri: movies[1].preview }} style={styles.image} />
    <Text style={styles.description}>{movies[1].shortDescription}</Text>
    <Text style={styles.description}>{movies[1].fullDescription}</Text>
    <Button title="Назад" onPress={() => navigation.goBack()} />
    <Button title="Далее" onPress={() => navigation.navigate('Fourth')} />
  </ScrollView>
);

const Fourth = ({ navigation }) => (
  <ScrollView contentContainerStyle={styles.container}>
    <Text style={styles.title}>{movies[2].title}</Text>
    <Image source={{ uri: movies[2].preview }} style={styles.image} />
    <Text style={styles.description}>{movies[2].shortDescription}</Text>
    <Text style={styles.description}>{movies[2].fullDescription}</Text>
    <Button title="Назад" onPress={() => navigation.goBack()} />
  </ScrollView>
);

const Stack = createStackNavigator();

function StackNavigator() {
  return (
    <Stack.Navigator initialRouteName="Start">
      <Stack.Screen name="Start" component={Start} options={{ title: 'Трилогия' }} />
      <Stack.Screen name="Second" component={Second} options={{ title: 'Братство Кольца' }} />
      <Stack.Screen name="Third" component={Third} options={{ title: 'Две Башни' }} />
      <Stack.Screen name="Fourth" component={Fourth} options={{ title: 'Возвращение Короля' }} />
    </Stack.Navigator>
  );
}

const Drawer = createDrawerNavigator();

function DrawerNavigator() {
  return (
    <Drawer.Navigator>
      <Drawer.Screen name="Главная" component={StackNavigator} />
      <Drawer.Screen name="Братство Кольца" component={Second} />
      <Drawer.Screen name="Две Башни" component={Third} />
      <Drawer.Screen name="Возвращение Короля" component={Fourth} />
    </Drawer.Navigator>
  );
}

export default function App() {
  return (
    <SafeAreaProvider>
      <NavigationContainer>
        <DrawerNavigator />
      </NavigationContainer>
    </SafeAreaProvider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    textAlign: 'center',
  },
  description: {
    fontSize: 16,
    textAlign: 'center',
    marginBottom: 20,
  },
  image: {
    width: 300,
    height: 450,
    marginBottom: 20,
  },
});
