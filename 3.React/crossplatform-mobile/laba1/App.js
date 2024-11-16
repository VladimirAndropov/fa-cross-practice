import React from 'react';
import { SafeAreaView, StyleSheet, Platform, Text } from 'react-native';
import GifGallery from './components/GifGallery';

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>
        Галерея гифок
      </Text>
      <GifGallery />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
    paddingTop: 20
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    textAlign: 'center',
    marginVertical: 10,
  },
});
