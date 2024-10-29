import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, SafeAreaView, Button } from 'react-native';
import { styles } from '../styles/styles';

export default function StartScreen({ navigation }) {
    return (
        <View style={styles.container}>
            <Text style={styles.text}>Привет, это первый экран!</Text>
            <StatusBar style="auto" />
            <Button title="Перети на второй экран" onPress={() => navigation.navigate('Second')} />
        </View>
    );
}