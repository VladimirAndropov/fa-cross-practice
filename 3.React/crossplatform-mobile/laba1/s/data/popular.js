import React from 'react';
import { View, Text, FlatList, Image, StyleSheet } from 'react-native';
import { COLORS, SIZES } from '../constants';
import { categories } from '../data/categories';

export default ProductList = () => {
  return (
    <View style={{ padding: SIZES.padding }}>
      <Text style={styles.headerText}>Новинки</Text>
      <FlatList
        data={categories}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <View style={styles.itemContainer}>
            <Image source={{ uri: item.image }} style={styles.image} />
            <Text style={styles.title}>{item.name}</Text>
            <Text style={styles.price}>{item.price}</Text>
          </View>
        )}
        numColumns={2}
        columnWrapperStyle={styles.row}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  headerText: {
    fontSize: SIZES.h1,
    fontWeight: 'bold',
    color: COLORS.black,
    marginBottom: 20,
  },
  row: {
    justifyContent: 'space-between',
  },
  itemContainer: {
    backgroundColor: COLORS.gray,
    borderRadius: SIZES.radius,
    padding: SIZES.base,
    width: '48%',
    marginBottom: SIZES.base,
    alignItems: 'center',
  },
  image: {
    width: 80,
    height: 80,
    marginBottom: 10,
  },
  title: {
    fontSize: SIZES.h3,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  price: {
    fontSize: SIZES.h4,
    color: COLORS.primary,
  },
});


