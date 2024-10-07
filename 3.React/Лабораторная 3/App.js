import React, { useState } from 'react';
import { StyleSheet, Text, SafeAreaView, ScrollView, View, TextInput, Image, Button, Alert, TouchableOpacity } from 'react-native';

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
  const [showFullDescription, setShowFullDescription] = useState(false);

  return (
    <View style={styles.movieBlock}>
      <Text style={styles.movieTitle}>{movie.title}</Text>
      <Image source={{ uri: movie.preview }} style={styles.image} />
      <Text style={styles.description}>
        {showFullDescription ? movie.fullDescription : movie.shortDescription}
      </Text>
      <TouchableOpacity
        onPress={() => setShowFullDescription(!showFullDescription)}
        style={styles.button}
      >
        <Text style={styles.buttonText}>
          {showFullDescription ? 'Скрыть' : 'Подробнее'}
        </Text>
      </TouchableOpacity>
    </View>
  );
};

const App = () => {
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.trilogyTitle}>The Lord of the Rings Trilogy</Text>
        <Text style={styles.author}>by J.R.R. Tolkien</Text>
      </View>
      <ScrollView horizontal contentContainerStyle={styles.scrollView}>
        {movies.map((movie, index) => (
          <MovieBlock key={index} movie={movie} />
        ))}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  header: {
    alignItems: 'center',
    marginBottom: 20,
  },
  trilogyTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 5,
  },
  author: {
    fontSize: 18,
    fontStyle: 'italic',
    color: '#555',
  },
  container: {
    flex: 1,
    backgroundColor: '#f0f0f0',
    padding: 20,
  },
  scrollView: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 10,
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
    marginHorizontal: 10,
    height: 450,
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
  description: {
    fontSize: 14,
    color: '#555',
    marginBottom: 10,
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
});

export default App;