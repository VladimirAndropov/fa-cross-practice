import React from 'react';
import { StyleSheet, Text, View, Image, ScrollView, TouchableOpacity, Alert } from 'react-native';

export default function App() {

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Журнал Bright</Text>
      </View>

      <View style={styles.news}>
        <Text style={styles.newsTitle}>Новости</Text>
        <View style={styles.newsItem}>
          <Image
            source={{ uri: 'https://avatars.mds.yandex.net/i?id=3413a024d9229277f7ffa99de3af22e0b616b9a9-8265302-images-thumbs&n=13' }}
            style={styles.newsImage}
          />
          <View style={styles.newsContent}>
            <Text style={styles.newsHeading}>Превращаем стресс в своего помощника</Text>
            <Text style={styles.newsText}>
              Исследователи Йельского университета заявляют, что люди, которые рассматривают стресс, как возможность личностного роста, отмечают улучшение качества жизни. Сегодня узнаем, как это работает и как увидеть положительные стороны стресса.
            </Text>
            <TouchableOpacity style={styles.readMoreButton}>
              <Text style={styles.readMoreText}>Читать далее</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    padding: 20,
  },
  header: {
    alignItems: 'center',
    marginBottom: 20,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
  },
  news: {
    backgroundColor: '#f9f9f9',
    padding: 20,
    borderRadius: 8,
  },
  newsTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  newsItem: {
    flexDirection: 'column',
    alignItems: 'center',
  },
  newsImage: {
    width: '100%',
    height: 150,
    marginBottom: 20,
    borderRadius: 8,
  },
  newsContent: {
    width: '100%',
    alignItems: 'center',
  },
  newsHeading: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 5,
    textAlign: 'center',
  },
  newsText: {
    fontSize: 14,
    textAlign: 'center',
    marginBottom: 10,
  },
  readMoreButton: {
    backgroundColor: '#007bff',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
  },
  readMoreText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
});