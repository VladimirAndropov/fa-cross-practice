import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, ScrollView, SafeAreaView, Image, Linking, Button } from 'react-native';

export default function App() {

  const news = `Исследователи Йельского университета заявляют, что люди, которые рассматривают стресс, как возможность личностного роста, отмечают улучшение качества жизни. Сегодня узнаем, как это работает и как увидеть положительные стороны стресса.`;
  const [showMore, setShowMore] = React.useState(false);

  const getNews = (text) => {
    if (showMore) {
      return text;
    }
    return text.substring(0, 100) + '...';
  };

  return (
    <View style={styles.background_container}>
      <SafeAreaView style={styles.safe_area}>
        <View style={styles.container}>
          <Text style={[styles.title, { paddingTop: 20 }]}>Журнал Bright</Text>
          <View style={styles.cardBackgroundContainer}>
            <ScrollView contentContainerStyle={styles.scrollViewContent}>
              <Text style={[styles.newsTitle, styles.textPadding, styles.leftAlign]} onPress={() => Linking.openURL('http://google.com')}>
                Новости
              </Text>

              <Image style={styles.image} source={require('./img/psycho.png')} />

              <Text style={[styles.title, styles.textPadding]}>
                Превращаем стресс в своего помощника
              </Text>

              <Text style={styles.normalText}>{getNews(news.repeat(2))}</Text>

              <View style={styles.buttonContainer}>
                <Button title={showMore ? 'Скрыть' : 'Показать больше'} onPress={() => setShowMore(!showMore)} />
              </View>
            </ScrollView>
          </View>
        </View>
      </SafeAreaView>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  newsTitle: {
    color: '#0C0CFF',
    fontSize: 20,
  },
  background_container: {
    backgroundColor: '#ECF0F1',
    flex: 1, // Занять все доступное пространство
  },
  safe_area: {
    flex: 1,
  },
  container: {
    alignItems: 'center',
    justifyContent: 'center',
    flex: 1, // Занять все доступное пространство
  },
  cardBackgroundContainer: {
    backgroundColor: '#fff',
    margin: 10,
    borderRadius: 10,
    flex: 1, // Позволить контейнеру занимать доступное пространство
  },
  scrollViewContent: {
    paddingTop: 20, // Добавить отступ сверху
    paddingBottom: 20, // Опционально: добавить отступ снизу для улучшения пробелов
    paddingHorizontal: 30, // Отступы слева и справа для текста
  },
  image: {
    width: 300,
    height: 150,
    marginBottom: 20, // Пространство под изображением
  },
  normalText: {
    fontSize: 20,
  },
  title: {
    fontSize: 30,
    fontWeight: 'bold',
  },
  textPadding: {
    paddingBottom: 30,
    paddingTop: 30,
  },
  leftAlign: {
    textAlign: 'left', // Выравнивание текста "Новости" по левому краю
    width: '100%', // Занять всю ширину родительского элемента
  },
  buttonContainer: {
    marginTop: 20, // Добавим верхний отступ для кнопки
  },
});
