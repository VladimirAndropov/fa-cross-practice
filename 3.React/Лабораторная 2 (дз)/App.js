import React from 'react';
import { View, Text, StyleSheet, ScrollView, Button, Alert } from 'react-native';

export default function App() {

  return (
    <ScrollView contentContainerStyle={styles.container}>
      <View style={styles.titleContainer}>
        <Text style={styles.title}>5 книжных новинок октября</Text>
      </View>
      <View style={styles.bookContainer}>
        <Text style={styles.bookTitle}>«Кадиш.com» Натан Ингландер.</Text>
        <Text style={styles.publisher}>Издательство «Книжники»</Text>
      </View>
      <View style={styles.descriptionContainer}>
        <Text style={styles.description}>
          Ироничная новелла Натана Ингландера, две личные истории культовой Патти Смит,
          репортаж британской журналистки о будущем человечества, дебютный роман Оушена
          Вуонга и журналистское расследование о создании «Моссада». В нашей подборке
          рассказываем о пяти захватывающих книжных новинках, которые достойны того, чтобы
          появиться на ваших полках.
        </Text>
        <View style={styles.buttonContainer}>
          <Button title="Читать далее" />
        </View>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flexGrow: 1,
    padding: 20,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
  },
  titleContainer: {
    marginBottom: 20,
    alignItems: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  bookContainer: {
    marginBottom: 20,
    backgroundColor: '#e6e6e6',
    padding: 15,
    borderRadius: 5,
  },
  bookTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 5,
  },
  publisher: {
    fontSize: 16,
    textAlign: 'center',
  },
  descriptionContainer: {
    backgroundColor: '#d9d9d9',
    padding: 15,
    borderRadius: 5,
  },
  description: {
    fontSize: 16,
    textAlign: 'center',
  },
  buttonContainer: {
    marginTop: 20,
    alignItems: 'center',
  },
});