import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, SafeAreaView, Button } from 'react-native';
import { styles } from '../styles/styles';


export default function SecondScreen({ navigation }) {
    return (<View style={styles.container}>
        <Text style={[styles.text, { paddingBottom: 10 }]} >Вторая страница</Text>

        <Button title="Назад" onPress={() => navigation.goBack()}> </Button>
        <Button title="Третий экран" onPress={() => navigation.navigate('Third')}> </Button>

    </View>);

};