import React from 'react';
import { Text, SafeAreaView, Image, StyleSheet } from 'react-native';
import { Card } from 'react-native-paper';

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.header}>Журнал Bright</Text>
      <Text style={styles.newsLink}>Новости</Text>
      <Card style={styles.card}>
        <Image
          source={{ uri: 'https://mts-link.ru/images/articles/kak-provesti-soveshanie-online/kak-provesti-soveshanie-online-01.webp' }} 
          style={styles.image}
        />
        <Text style={styles.title}>Превращаем стресс в своего помощника</Text>
        <Text style={styles.text}>
          Исследователи Йельского университета заявляют, что люди, которые рассматривают стресс как возможность личностного роста, отмечают улучшение качества жизни. Сегодня узнаем, как это работает и как увидеть положительные стороны стресса.
        </Text>
      </Card>
    </SafeAreaView>
  );
}



const styles = StyleSheet.create({
  container: {
    marginTop: 50,
  },
  header: {
    fontSize: 18,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  newsLink: {
    color: 'blue',
    textAlign: 'center',
    fontSize: 16,
  },
  card: {
    padding: 20,
    backgroundColor: 'lightblue'
  },
  image: {
    width: '100%',
    height: 200,
  },
  title: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  text: {
    fontSize: 14,
  },
});

