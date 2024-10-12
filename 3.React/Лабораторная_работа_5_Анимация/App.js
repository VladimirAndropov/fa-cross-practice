import React, { useRef, useEffect } from "react";
import {
  SafeAreaView,
  ScrollView,
  Text,
  StyleSheet,
  View,
  ImageBackground,
  Animated,
  TouchableOpacity,
  useWindowDimensions
} from "react-native";

const images = [
  'https://funik.ru/wp-content/uploads/2018/10/17478da42271207e1d86.jpg',
  'https://avatars.mds.yandex.net/i?id=5e13aa757d33705c6f8941b9f8a56b94_l-7993564-images-thumbs&n=13',
  'https://avatars.mds.yandex.net/i?id=e339fc622756af285f34aa7777d37444_l-5234706-images-thumbs&n=13',
  'https://avatars.mds.yandex.net/i?id=a4621618cf1f95ef74dce3638f67efdc_l-7544543-images-thumbs&n=13',
  'https://avatars.mds.yandex.net/i?id=973bfe9f23a190f32e1d7b691e72dd92_l-5250823-images-thumbs&n=13',
  'https://avatars.mds.yandex.net/i?id=cb3506e3f70d631b0793288cb47ddec9_l-5222428-images-thumbs&n=13'
];

const LaunchScreen = ({ onAnimationEnd }) => {
  const fadeAnim = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(fadeAnim, {
      toValue: 1,
      duration: 3000,
      useNativeDriver: true,
    }).start(() => onAnimationEnd()); 
  }, [fadeAnim]);

  return (
    <Animated.View style={[styles.launchContainer, { opacity: fadeAnim }]}>
      <Text style={styles.launchText}>Добро пожаловать в приложение "Фото котов"</Text>
    </Animated.View>
  );
};

const AnimatedButton = () => {
  const colorAnim = useRef(new Animated.Value(0)).current;

  const handlePress = () => {
    Animated.timing(colorAnim, {
      toValue: colorAnim._value === 0 ? 1 : 0,
      duration: 500,
      useNativeDriver: false,  
    }).start();
  };

  const backgroundColor = colorAnim.interpolate({
    inputRange: [0, 1],
    outputRange: ['rgba(0,150,136,1)', 'rgba(255,87,34,1)'],
  });

  return (
    <TouchableOpacity onPress={handlePress}>
      <Animated.View style={[styles.button, { backgroundColor }]}>
        <Text style={styles.buttonText}>Нажми меня! Я меняю цвет!</Text>
      </Animated.View>
    </TouchableOpacity>
  );
};

const App = () => {
  const scrollX = useRef(new Animated.Value(0)).current;
  const { width: windowWidth } = useWindowDimensions();
  const [isLaunchScreenVisible, setIsLaunchScreenVisible] = React.useState(true);

  const handleLaunchScreenEnd = () => {
    setIsLaunchScreenVisible(false); 
  };

  return (
    <SafeAreaView style={styles.container}>
      {isLaunchScreenVisible ? (
        <LaunchScreen onAnimationEnd={handleLaunchScreenEnd} />
      ) : (
        <View style={styles.mainContent}>
          <View style={styles.scrollContainer}>
            <ScrollView
              horizontal={true}
              style={styles.scrollViewStyle}
              pagingEnabled
              showsHorizontalScrollIndicator={false}
              onScroll={Animated.event([
                {
                  nativeEvent: {
                    contentOffset: {
                      x: scrollX
                    }
                  }
                }
              ], { useNativeDriver: false })}
              scrollEventThrottle={1}
            >
              {images.map((image, imageIndex) => {
                return (
                  <View style={{ width: windowWidth, height: 250 }} key={imageIndex}>
                    <ImageBackground source={{ uri: image }} style={styles.card}>
                      <View style={styles.textContainer}>
                        <Text style={styles.infoText}>{"Фото - " + imageIndex}</Text>
                      </View>
                    </ImageBackground>
                  </View>
                );
              })}
            </ScrollView>
            <View style={styles.indicatorContainer}>
              {images.map((image, imageIndex) => {
                const width = scrollX.interpolate({
                  inputRange: [
                    windowWidth * (imageIndex - 1),
                    windowWidth * imageIndex,
                    windowWidth * (imageIndex + 1)
                  ],
                  outputRange: [8, 16, 8],
                  extrapolate: "clamp"
                });
                return (
                  <Animated.View
                    key={imageIndex}
                    style={[styles.normalDot, { width }]}
                  />
                );
              })}
            </View>
          </View>
          <AnimatedButton />
        </View>
      )}
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "#fff",
  },
  launchContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  launchText: {
    fontSize: 32,
    fontWeight: "bold",
    color: "#333",
    textAlign: "center"
  },
  mainContent: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  scrollContainer: {
    height: 300,
    alignItems: "center",
    justifyContent: "center",
  },
  scrollViewStyle: {
    flexDirection: 'row',
  },
  card: {
    flex: 1,
    marginVertical: 4,
    marginHorizontal: 16,
    borderRadius: 5,
    overflow: "hidden",
    alignItems: "center",
    justifyContent: "center",
  },
  textContainer: {
    backgroundColor: "rgba(0,0,0, 0.7)",
    paddingHorizontal: 24,
    paddingVertical: 8,
    borderRadius: 5,
  },
  infoText: {
    color: "white",
    fontSize: 16,
    fontWeight: "bold",
  },
  normalDot: {
    height: 8,
    width: 8,
    borderRadius: 4,
    backgroundColor: "silver",
    marginHorizontal: 4,
  },
  indicatorContainer: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
  },
  button: {
    padding: 20,
    borderRadius: 10,
    marginTop: 20,
  },
  buttonText: {
    color: "white",
    fontWeight: "bold",
  },
});

export default App;
