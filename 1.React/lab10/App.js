import React, { useEffect, useState } from 'react';
import { SafeAreaView, View, FlatList, ActivityIndicator, StyleSheet, Image, Dimensions } from 'react-native';
import axios from 'axios';

const GIPHY_API_KEY = ''; 

export default function App() {
  const [gifs, setGifs] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchGifs = async () => {
      try {
        const response = await axios.get(
          'https://api.giphy.com/v1/gifs/trending',
          {
            params: {
              api_key: GIPHY_API_KEY,
              limit: 25,
            },
          }
        );
        setGifs(response.data.data);
      } catch (error) {
        console.error(error);
      } finally {
        setLoading(false);
      }
    };

    fetchGifs();
  }, []);

  if (loading) {
    return <ActivityIndicator size="large" color="#0000ff" style={styles.loader} />;
  }

  return (
    <SafeAreaView style={styles.container}>
      <FlatList
        data={gifs}
        keyExtractor={(item) => item.id}
        numColumns={2}
        renderItem={({ item }) => (
          <Image
            style={styles.image}
            source={{
              uri: item.images.fixed_width.url,
            }}
            resizeMode="contain"
          />
        )}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  loader: {
    flex: 1,
    justifyContent: 'center',
  },
  image: {
    width: Dimensions.get('window').width / 2 - 2,
    height: 200,
    margin: 1,
  },
});
