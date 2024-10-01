import React from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';

const FlexDimensionsBasics = () => {
  return (
    <View style={styles.baseview}>
      <View style={styles.baseview}>
        <Text style={[styles.text, styles.bold]}>
          5 книжных новинок октбяря

        </Text>
      </View>
      <View style={styles.view2}>
        <Text style={[styles.text, styles.font]}>
          "Кадиш.com" Натан Ингландер. <br />
          Издательство "Книжники"
        </Text>
      </View>
      <View style={styles.view3}>
        <Text style={styles.text}>
 Ироничная новелла Натана Ингландера, две личные истории культовой Патти Смит, репортаж британской журналистки о будущем человечества, дебютный роман Оушена Вуонга и журналистское расследование о создании "Моссада". В нашей подборке рассказываем о пяти захватывающих книжных новинках, которые достойны того, чтобы появиться на ваших полках.
        </Text>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  baseview: {
    flex: 1,
    backgroundColor: '#FFF',
    padding: 'auto',
  },
  view2: {
    flex: 1,
    backgroundColor: '#e5e5e5',
  },
  view3: {
    flex: 6,
    backgroundColor: '#aaa',
  },
  text: {
    margin: 'auto',
    justifyContent: 'center',
    textAlign: 'center',
    paddingStart: '5%',
    paddingEnd: '5%',
  },
  bold: {
    fontWeight: 'bold',
  },
  font: {
    fontSize: '15',
  },
});

export default FlexDimensionsBasics;