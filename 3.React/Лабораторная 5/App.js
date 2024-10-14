import { useRef, useState, useEffect } from "react";
import {
  SafeAreaView,
  ScrollView,
  Text,
  StyleSheet,
  View,
  Animated,
  useWindowDimensions,
  TouchableOpacity,
  Image
} from "react-native";

const movies = [
  {
    title: 'The Fellowship of the Ring',
    preview: 'https://upload.wikimedia.org/wikipedia/en/f/fb/Lord_Rings_Fellowship_Ring.jpg',
    shortDescription: 'The first chapter in the epic Lord of the Rings trilogy.',
    fullDescription: 'The young hobbit Frodo Baggins is tasked with the monumental journey to destroy the One Ring in the fires of Mount Doom. Accompanied by the Fellowship of the Ring, they face numerous trials, dangers, and treachery across Middle-earth.'
  },
  {
    title: 'The Two Towers',
    preview: 'https://upload.wikimedia.org/wikipedia/en/a/a1/Lord_Rings_Two_Towers.jpg',
    shortDescription: 'The second chapter of the Lord of the Rings saga.',
    fullDescription: 'The Fellowship is broken, but the fight against Sauron and his allies continues. Frodo and Sam continue their perilous journey towards Mount Doom, while Aragorn, Legolas, and Gimli battle Saruman’s forces and prepare for the coming war.'
  },
  {
    title: 'The Return of the King',
    preview: 'https://upload.wikimedia.org/wikipedia/en/4/48/Lord_Rings_Return_King.jpg',
    shortDescription: 'The final chapter of the Lord of the Rings trilogy.',
    fullDescription: 'As Sauron’s armies close in, Frodo and Sam edge ever closer to Mount Doom. Aragorn must claim his birthright as King of Gondor and rally the forces of Middle-earth for a climactic battle against the Dark Lord.'
  }
];



const MovieBlock = ({ movie }) => {
  const [expanded, setExpanded] = useState(false);
  const descriptionHeight = useRef(new Animated.Value(0)).current;

  return (
    <View style={styles.movieBlock}>
      <Text style={styles.movieTitle}>{movie.title}</Text>
      <Image source={{ uri: movie.preview }} style={styles.image} />
      <Text style={styles.shortDescription}>{movie.shortDescription}</Text>

      <Animated.View style={{ height: descriptionHeight, overflow: 'hidden' }}>
        <Text style={styles.fullDescription}>
          {movie.fullDescription}
        </Text>
      </Animated.View>

      <TouchableOpacity
        onPress={() => {
          setExpanded(!expanded);
          Animated.timing(descriptionHeight, {
            toValue: expanded ? 0 : 100,
            duration: 400,
            useNativeDriver: false
          }).start();
        }}
        style={styles.button}
      >
        <Text style={styles.buttonText}>
          {expanded ? 'Скрыть' : 'Подробнее'}
        </Text>
      </TouchableOpacity>
    </View>
  );
};

const LaunchScreen = ({ onFinish }) => {
  const opacity = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(opacity, {
      toValue: 1,
      duration: 500,
      useNativeDriver: true,
    }).start(() => {
      setTimeout(() => {
        Animated.timing(opacity, {
          toValue: 0,
          duration: 500,
          useNativeDriver: true,
        }).start(onFinish);
      }, 1000);
    });
  });

  return (
    <Animated.View style={[styles.launchScreenContainer, { opacity }]}>
      <Text style={styles.launchText}>Welcome to Middle-earth</Text>
      <Image
        source={{ uri: 'https://yastatic.net/naydex/yandex-search/Ftn8X0q20/0551d4mPwfVU/-G4G07TVR2WXSTxj_BsvcE3mYJrEX0nmd94njxU-aylj1FZuV7slvLZrnPr7fdo28RYDhQZ1UrKjkOhNHhHxYcl6wrfFQMIh1rx848xLDqWZ13FfZBqYQlIbo-qAi45pwEKEPFXIkj-E7O4tH7jKg7QCElGnYzFw' }}
        style={styles.launchCenterImage}
      />
    </Animated.View>
  );
};

const App = () => {
  const [isLaunchScreenVisible, setIsLaunchScreenVisible] = useState(true);
  const scrollX = useRef(new Animated.Value(0)).current;
  const { width: windowWidth } = useWindowDimensions();

  if (isLaunchScreenVisible) {
    return <LaunchScreen onFinish={() => setIsLaunchScreenVisible(false)} />;
  }

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.trilogyTitle}>The Lord of the Rings Trilogy</Text>
      <Text style={styles.author}>by J.R.R. Tolkien</Text>

      <View style={styles.scrollContainer}>
        <ScrollView
          horizontal={true}
          pagingEnabled
          showsHorizontalScrollIndicator={false}
          onScroll={Animated.event(
            [{ nativeEvent: { contentOffset: { x: scrollX } } }],
            { useNativeDriver: false }
          )}
          scrollEventThrottle={1}
        >
          {movies.map((movie, index) => (
            <View style={{ width: windowWidth, height: 450 }} key={index}>
              <MovieBlock movie={movie} />
            </View>
          ))}
        </ScrollView>
        <View style={styles.indicatorContainer}>
          {movies.map((_, imageIndex) => {
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
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f0f0f0',
    paddingVertical: 40,
  },
  trilogyTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  author: {
    fontSize: 18,
    fontStyle: 'italic',
    color: '#555',
    textAlign: 'center',
    marginBottom: 20,
  },
  scrollContainer: {
    height: 520,
  },
  movieBlock: {
    width: 300,
    padding: 20,
    backgroundColor: '#fff',
    borderRadius: 10,
    shadowColor: '#000',
    shadowOpacity: 0.1,
    shadowRadius: 10,
    elevation: 5,
    marginHorizontal: 50,
    height: 480,
  },
  movieTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  image: {
    width: '100%',
    height: 200,
    borderRadius: 10,
    marginBottom: 10,
    resizeMode: 'contain',
  },
  shortDescription: {
    fontSize: 14,
    color: '#555',
    marginBottom: 10,
  },
  fullDescription: {
    fontSize: 14,
    color: '#555',
    marginTop: 10,
  },
  button: {
    backgroundColor: '#007BFF',
    padding: 10,
    borderRadius: 5,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
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
    justifyContent: "center",
    alignItems: "center",
    marginTop: 20,
  },
  launchScreenContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#000',
  },
  launchText: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#fff',
    marginBottom: 20,
  },
  launchCenterImage: {
    width: 400,
    height: 400,
    resizeMode: 'contain',
  },
});

export default App;