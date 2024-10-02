import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, ScrollView, SafeAreaView } from 'react-native';

export default function App() {
  return (
    
    <View style={styles.container}>
      <SafeAreaView style={{flex: 1}}>
          <View style={styles.firstContainer}>
            <Text style={[styles.textStyle, styles.boldText, styles.bigText]}>5 книжных новинок октября</Text>
            <StatusBar style="auto" />
          </View>
          <View style={styles.secondContainer}>
            <Text style={[styles.textStyle,  styles.bigText]}>«Кадиш.сот» Натан Ингландер.
            Издательство «Книжники»</Text>
          </View>
          <View style={styles.thirdContainer}>
            <Text style={styles.textStyle}>Ироничная новелла Натана Ингландера, две личные истории культовой Патти Смит, репортаж британской журналистки о будущем человечества, дебютный роман Оушена Вуонга и журналистское расследование о создании «Моссада». В нашей подборке рассказываем о пяти захватывающих книжных новинках, которые достойны того, чтобы появиться на ваших полках.</Text>
          </View>
      </SafeAreaView>
    </View>




  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  textStyle: {
    marginTop: 20,
    marginLeft: 20,
    marginRight: 20,
    textAlign: 'center',
  },
  boldText: {
    fontWeight: 'bold',
  },
  bigText:{
    fontSize: 20,
  },
  container: {
    flex: 1,
    // flexDirection: 'column',
    // backgroundColor: '#A9A9FF',
    // alignItems: 'stretch',
  },
  firstContainer: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  secondContainer: {
    flex: 2,
    backgroundColor: '#D3D3D3',
    alignItems: 'center',
    justifyContent: 'center',
  },
  thirdContainer: {
    flex: 10,
    backgroundColor: '#A9A9A9',
    alignItems: 'center',
    // justifyContent: 'center',
  }
});