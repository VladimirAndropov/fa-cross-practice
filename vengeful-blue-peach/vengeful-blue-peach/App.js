import React from 'react';
import { View, Text, Image, StyleSheet, ScrollView, SafeAreaView } from 'react-native';

const App = () => {
  return (
    <SafeAreaView style={styles.safeArea}>
      <ScrollView contentContainerStyle={styles.container}>
        <View style={styles.card}>
          <Text style={styles.header}>Журнал Bright</Text>

          <View style={styles.newsSection}>
            <Text style={styles.newsTitle}>Новости</Text>
            <Image
              source={{ uri: 'https://etozheludok.ru/wp-content/uploads/2018/03/stress.jpg' }} 
              style={styles.newsImage}
            />
            <Text style={styles.articleTitle}>
              Превращаем стресс в своего помощника
            </Text>
            <Text style={styles.articleText}>
              Исследователи Йельского университета заявляют, что люди, которые
              рассматривают стресс, как возможность личностного роста, отмечают
              улучшение качества жизни. Сегодня узнаем, как это работает и как
              увидеть положительные стороны стресса.
            </Text>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#f5f5f5', // Adjust background color to match your theme
  },
  container: {
    flexGrow: 1,
    padding: 20,
    justifyContent: 'center',
    backgroundColor: '#f5f5f5',
  },
  card: {
    backgroundColor: '#fff',
    borderRadius: 8,
    padding: 16,
    elevation: 3,
  },
  header: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 16,
    textAlign: 'center',
  },
  newsSection: {
    borderTopWidth: 1,
    borderTopColor: '#ccc',
    paddingTop: 16,
  },
  newsTitle: {
    fontSize: 18,
    color: '#4a90e2',
    marginBottom: 8,
  },
  newsImage: {
    width: '100%',
    height: 150,
    borderRadius: 8,
    marginBottom: 16,
  },
  articleTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  articleText: {
    fontSize: 16,
    color: '#666',
  },
});

export default App;