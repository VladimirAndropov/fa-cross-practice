import React, { useRef } from 'react';
import { View, Text, ScrollView, StyleSheet, ImageBackground, Animated, useWindowDimensions, SafeAreaView } from 'react-native';

const images = new Array(6).fill('https://images.unsplash.com/photo-1556740749-887f6717d7e4');

export default Slider = () => {
  const scrollX = useRef(new Animated.Value(0)).current;
  const { width: windowWidth } = useWindowDimensions();

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.scrollContainer}>
        <ScrollView
          horizontal
          pagingEnabled
          showsHorizontalScrollIndicator={false}
          onScroll={Animated.event(
            [{ nativeEvent: { contentOffset: { x: scrollX } } }],
            { useNativeDriver: false }
          )}
          scrollEventThrottle={16}
        >
          {images.map((image, index) => (
            <View style={{ width: windowWidth, height: 250 }} key={index}>
              <ImageBackground source={{ uri: image }} style={styles.card}>
                <View style={styles.textContainer}>
                  <Text style={styles.infoText}>Image - {index}</Text>
                </View>
              </ImageBackground>
            </View>
          ))}
        </ScrollView>
        <View style={styles.indicatorContainer}>
          {images.map((_, index) => {
            const width = scrollX.interpolate({
              inputRange: [
                windowWidth * (index - 1),
                windowWidth * index,
                windowWidth * (index + 1),
              ],
              outputRange: [8, 16, 8],
              extrapolate: 'clamp',
            });
            return <Animated.View key={index} style={[styles.dot, { width }]} />;
          })}
        </View>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: { alignItems: 'center', justifyContent: 'center' },
  scrollContainer: { height: 300, justifyContent: 'center' },
  card: { flex: 1, margin: 16, borderRadius: 5, overflow: 'hidden' },
  textContainer: { backgroundColor: 'rgba(0,0,0,0.5)', padding: 10, borderRadius: 5 },
  infoText: { color: '#fff', fontSize: 16, fontWeight: 'bold' },
  indicatorContainer: { flexDirection: 'row', justifyContent: 'center', marginTop: 10 },
  dot: { height: 8, width: 8, backgroundColor: 'silver', marginHorizontal: 4, borderRadius: 4 },
});


