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
            <View style={styles.paddedContent}>

              <ScrollView>
                <Text style={[styles.newsTitle, styles.textPadding]} onPress={() => Linking.openURL('http://google.com')}>
                  Новости</Text>

                <Image style={{ width: 300, height: 150, }}
                  source={require('./img/psycho.png')}>
                </Image>

                <Text style={[styles.title, styles.textPadding]} class='padding10'>
                  Превращаем стрес в своего помощника</Text>

                <Text style={styles.normalText}>{getNews(news.repeat(2))}</Text>

                <Button title={showMore ? 'Скрыть' : 'Показать больше'} onPress={() => setShowMore(!showMore)}></Button>

                <StatusBar style="auto" />
              </ScrollView>

            </View>
          </View>
        </View>
      </SafeAreaView>

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
    height: '100%',
    width: '100%',
  },

  safe_area: {
    flex: 1,
  },

  container: {
    alignItems: 'center',
    justifyContent: 'center',
  },

  cardBackgroundContainer: {
    backgroundColor: '#fff',
    margin: 10,
    borderRadius: 10,

  },

  paddedContent: {
    margin: 20,
    alignItems: 'center',
    justifyContent: 'center',
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



});
