import React from 'react';
import { SafeAreaView, StyleSheet, Text, Image, Button, Alert, View } from 'react-native';

const onButtonPress = () => {
  Alert.alert('Оплатите подписку');
};

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>
        Баварские сосиски и картошка
      </Text>

      <Image
        style={styles.image}
        source={{ uri: 'https://avatars.mds.yandex.net/i?id=c86056a323dbb9dab0e99cebced1134b_l-10700023-images-thumbs&n=13' }} 
      />

      <Button
        title="Узнать рецепт"
        onPress={onButtonPress}
      />
    </SafeAreaView>
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
    textAlign: "center",
  },
  image: {
    width: 200,
    height: 200,
    marginBottom: 20,
  },
});
