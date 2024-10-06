import React from 'react';
import { Text, SafeAreaView, StyleSheet, View } from 'react-native';
import { Card } from 'react-native-paper';

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.header}>5 книжных новинок октября</Text>
      <Card style={styles.card}>
        <View style={styles.bookInfo}>
          <Text style={styles.bookTitle}>«Кадиш.com» Натан Ингландер.</Text>
          <Text style={styles.bookPublisher}>Издательство «Книжники»</Text>
        </View>
        <View style={styles.descriptionContainer}>
          <Text style={styles.description}>
            Ироничная новелла Натана Ингландера, две личные истории культовой Патти Смит, репортаж британской журналистки о будущем человечества, дебютный роман Оушена Вуонга и журналистское расследование о создании «Моссада». В нашей подборке рассказываем о пяти захватывающих книжных новинках, которые достойны того, чтобы появиться на ваших полках.
          </Text>
        </View>
      </Card>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
  },
  header: {
    fontSize: 18,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  card: {
    padding: 40,
  },
  bookInfo: {
    backgroundColor: '#e0e0e0',
    padding: 10,
  },
  bookTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  bookPublisher: {
    fontSize: 14,
    textAlign: 'center',
  },
  descriptionContainer: {
    backgroundColor: '#d0d0d0',
  },
  description: {
    fontSize: 14,
    textAlign: 'center',
  },
});
