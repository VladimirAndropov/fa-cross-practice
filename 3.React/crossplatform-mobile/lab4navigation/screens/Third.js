import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, SafeAreaView, Button } from 'react-native';
import { Appbar } from 'react-native-paper';
import { styles } from '../styles/styles';

export default function ThirdScreen({ navigation }) {
    return (<View style={styles.container}>
        <Text style={[styles.text, { paddingBottom: 10 }]}>Привет, это третий экран!</Text>
        <StatusBar style="auto" />
        <Button title="Вернуться на второй экран" onPress={() => navigation.navigate('Second')} />
        <Button title="Вернуться на первый экран" onPress={() => navigation.navigate('Home')} />
    </View>);
}


