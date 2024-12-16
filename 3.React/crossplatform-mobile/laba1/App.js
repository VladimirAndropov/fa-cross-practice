// React Native project
import React from 'react';
import { StyleSheet, View, Text, ScrollView, Image, Dimensions , ImageBackground} from 'react-native';
import {LinearGradient} from 'expo-linear-gradient';

const App = () => {
  const icons = [
    require('./assets/icon0.png'),
    require('./assets/icon1.png'),
    require('./assets/icon2.png'),
    require('./assets/icon3.png'),
    require('./assets/icon4.png'),
  ];

  return (
    <LinearGradient colors={['#ff6ec4', '#7873f5']} style={styles.container}>
      {/* Верхний градиентный блок */}
      <LinearGradient colors={['#93E9EC', '#D493EE']} style={styles.header}>
        <Text style={styles.headerText}>Hope you are great, Anne!</Text>
        <Text style={styles.headerTextSmall}>Let's workout to get some gains!</Text>
      </LinearGradient>

      <ScrollView contentContainerStyle={styles.scrollContent}>
        {/* Block 1 */}
        <View style={styles.cardContainer}>
          {[1, 2, 3].map((item, index) => (
            <View style={styles.card} key={index}>
              <Image style={styles.icon} source={require('./assets/leading_icon.png')} />
              <View style={styles.cardContent}>
                <Text style={styles.cardTitle}>Title {item}</Text>
                <Text style={styles.cardSubtitle}>Subtitle {item}</Text>
              </View>
              <Image style={styles.icon} source={require('./assets/tt.png')} />
            </View>
          ))}
        </View>

        <View style={styles.separator} />

        <Text style={styles.blockTitle}>Block Title 1</Text>

        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.carousel}>
      {[1, 2, 3, 4].map((item) => (
        <ImageBackground 
          source={require('./assets/card-bg.png')} 
          style={styles.imageBackground} 
          key={item}
        >
          {/* Наложение полупрозрачного цвета */}
          <View style={styles.carouselCard}>
            <Text style={styles.carouselCardText}>Card {item}</Text>
          </View>
          <View style={[styles.overlay, { backgroundColor: getRandomColor() }]} />
          
        </ImageBackground>
      ))}
    </ScrollView>

        <View style={styles.separator} />

        <Text style={styles.blockTitle}>Block Title 2</Text>

        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.carousel}>
      {[1, 2, 3, 4].map((item) => (
        <ImageBackground 
          source={require('./assets/card-bg.png')} 
          style={styles.imageBackground} 
          key={item}
        >
          {/* Наложение полупрозрачного цвета */}
          <View style={styles.largeCarouselCard}>
            <Text style={styles.carouselCardText}>Card {item}</Text>
          </View>
          <View style={[styles.overlay, { backgroundColor: getRandomColor() }]} />
          
        </ImageBackground>
      ))}
    </ScrollView>
      </ScrollView>

      <View style={styles.navbar}>
      {icons.map((icon, index) => (
        <Image key={index} style={styles.navbarIcon} source={icon} />
      ))}
    </View>
    </LinearGradient>
  );
};

const getRandomColor = () => {
  const randomColor = `rgba(${Math.floor(Math.random() * 256)}, ${Math.floor(
    Math.random() * 256
  )}, ${Math.floor(Math.random() * 256)}, 0.7)`; // Прозрачность 0.2
  return randomColor;
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    padding: 20,
    alignItems: 'center',
    justifyContent: 'center',
    borderBottomLeftRadius: 30,
    borderBottomRightRadius: 30,
  },
  headerText: {
    color: 'white',
    fontSize: 24,
    fontWeight: 'bold',
  },
  headerTextSmall: {
    color: 'white',
    fontSize: 16,
    marginTop: 5,
  },
  scrollContent: {
    padding: 16,
  },
  cardContainer: {
    marginBottom: 16,
  },
  card: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  icon: {
    width: 24,
    height: 24,
    marginHorizontal: 8,
  },
  cardContent: {
    flex: 1,
  },
  cardTitle: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  cardSubtitle: {
    fontSize: 14,
    color: '#666',
  },
  separator: {
    height: 1,
    backgroundColor: '#ccc',
    marginVertical: 16,
  },
  blockTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 8,
    color: '#fff'
  },
  carousel: {
    marginBottom: 16,
  },
  carouselCard: {
    width: 1800,
    height: 180,
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 12,
    zIndex: 3
  },
  largeCarouselCard: {
    width: 180,
    height: 180,
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 12,
    zIndex: 3
  },
  carouselCardText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  
  navbarText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  navbar: {
    height: 60,
    backgroundColor: '#624396',
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
  },
  navbarIcon: {
    width: 24,
    height: 24,
    tintColor: '#fff',
  },
  carousel: {
    flexDirection: 'row',
    padding: 10,
  },
  imageBackground: {
    marginHorizontal: 5,
    borderRadius: 10,
    overflow: 'hidden', // чтобы края фона не выходили за пределы View
  },
  carouselCard: {
    width: 150,
    height: 200,
    justifyContent: 'center',
    alignItems: 'center',
    zIndex: 2,
  },
  carouselCardText: {
    zIndex: 3,
    fontSize: 16,
    fontWeight: 'bold',
    color: '#fff', // цвет текста на фоне
  },
  overlay: {
    ...StyleSheet.absoluteFillObject, // Заполняет всё пространство ImageBackground
    zIndex: 1, // Располагает наложение поверх фона, но под контентом
  },
});

export default App;
