import React, { useEffect, useState } from 'react';
import { View, StyleSheet, ScrollView, Image, TextInput, Button, Text } from 'react-native';

const API_KEY = 'EOWGcFZ2R31rB8NRrraxVRWRxdhykqv4';
const TRENDING_API_URL = `https://api.giphy.com/v1/gifs/trending?api_key=${API_KEY}&limit=10`;
const SEARCH_API_URL = `https://api.giphy.com/v1/gifs/search?api_key=${API_KEY}&limit=10&q=`;

export default function GifGallery() {
  const [gifs, setGifs] = useState([]);
  const [query, setQuery] = useState('');
  const [isSearching, setIsSearching] = useState(false);

  // Fetch trending GIFs on load
  useEffect(() => {
    fetchGifs(TRENDING_API_URL);
  }, []);

  // Function to fetch GIFs from the API
  const fetchGifs = async (url) => {
    try {
      setIsSearching(true);
      const response = await fetch(url);
      const json = await response.json();
      setGifs(json.data);
    } catch (error) {
      console.error('Error fetching GIFs:', error);
    } finally {
      setIsSearching(false);
    }
  };

  // Handle search button click
  const handleSearch = () => {
    if (query.trim()) {
      const searchUrl = SEARCH_API_URL + encodeURIComponent(query);
      fetchGifs(searchUrl);
    } else {
      // If query is empty, fetch trending GIFs
      fetchGifs(TRENDING_API_URL);
    }
  };

  return (
    <View style={styles.container}>
      {/* Search Input */}
      <View style={styles.searchContainer}>
        <TextInput
          style={styles.input}
          placeholder="Search GIFs..."
          value={query}
          onChangeText={setQuery}
        />
        <Button title="Search" onPress={handleSearch} />
      </View>

      {/* Loading Indicator */}
      {isSearching && <Text style={styles.loadingText}>Loading...</Text>}

      {/* GIF Gallery */}
      <ScrollView contentContainerStyle={styles.gallery}>
        {gifs.map((gif) => (
          <Image
            key={gif.id}
            source={{ uri: gif.images.fixed_width.url }}
            style={styles.gif}
          />
        ))}
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  searchContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 10,
  },
  input: {
    flex: 1,
    height: 40,
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 5,
    paddingHorizontal: 10,
    marginRight: 10,
  },
  loadingText: {
    textAlign: 'center',
    marginVertical: 10,
    color: '#888',
  },
  gallery: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
    padding: 10,
  },
  gif: {
    width: 150,
    height: 150,
    margin: 5,
    borderRadius: 10,
  },
});
