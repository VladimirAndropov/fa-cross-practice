import { Text, SafeAreaView, StyleSheet, View } from 'react-native';
import { Card } from 'react-native-paper';

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <Card style={styles.card}>
        <View style={styles.headerContainer}>
          <Text style={styles.header}>5 книжных новинок октября</Text>
        </View>

        <View style={styles.titleContainer}>
          <Text style={styles.title}>«Кадиш.com» Натан Ингландер. Издательство «Книжники»</Text>
        </View>

        <View style={styles.descriptionContainer}>
          <Text style={styles.description}>
            Ироничная новелла Натана Ингландера, две личные истории культовой Патти Смит, репортаж британской журналистки о будущем человечества, дебютный роман Оушена Вуонга и журналистское расследование о создании «Моссад». В нашей подборке рассказываем о пяти захватывающих книжных новинках, которые достойны того, чтобы появиться на ваших полках.
          </Text>
        </View>
      </Card>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#ecf0f1',
    padding: 16,
  },
  card: {
    width: '100%', 
    maxWidth: 400, 
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  headerContainer: {
    padding: 16,
  },
  header: {
    fontSize: 20,
    fontWeight: 'bold',
    textAlign: 'center',
    color: '#000', 
  },
  titleContainer: {
    backgroundColor: '#e0e0e0', 
    padding: 16,
  },
  title: {
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
    color: '#333',
  },
  descriptionContainer: {
    backgroundColor: '#757575', 
    padding: 16,
  },
  description: {
    fontSize: 14,
    textAlign: 'center',
    lineHeight: 20,
  },
});
