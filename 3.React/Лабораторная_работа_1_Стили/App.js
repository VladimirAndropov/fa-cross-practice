import { Text, Image, ScrollView, TouchableOpacity, View, StyleSheet, Alert } from 'react-native';

export default function App() {
  const handleReadMore = () => {
    Alert.alert('Читать далее');
  };
  return (
    <ScrollView contentContainerStyle={styles.outerContainer}>
      <Text style={styles.header}>Журнал Bright</Text>

      <View style={styles.contentContainer}>
        <Text style={styles.news}>Новости</Text>

        <Image
          style={styles.image}
          source={{ uri: 'https://avatars.mds.yandex.net/get-altay/6145759/2a00000182e0304cd81e67949dafa25e486a/XXL_height' }} 
        />

        <Text style={styles.title}>Превращаем стресс в своего помощника</Text>

        <Text style={styles.description}>
          Исследователи Йельского университета заявляют, что люди, которые рассматривают стресс, как возможность личностного роста, отмечают улучшение качества жизни. Сегодня узнаем, как это работает и как увидеть положительные стороны стресса.
        </Text>
        <TouchableOpacity style={styles.button} onPress={handleReadMore}>
          <Text style={styles.buttonText}>Читать далее</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  outerContainer: {
    padding: 20,
    backgroundColor: '#E0E0E0',
    alignItems: 'center',
  },
  header: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  contentContainer: {
    backgroundColor: '#FFFFFF', 
    borderRadius: 10,
    padding: 20,
    width: '100%',
  },
  news: {
    color: '#0066CC',
    fontSize: 18,
    alignSelf: 'flex-start',
    marginBottom: 10,
  },
  image: {
    width: '100%',
    height: 200,
    borderRadius: 10,
    marginBottom: 20,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 10,
    textAlign: 'left',
  },
  description: {
    fontSize: 16,
    textAlign: 'left',
    color: '#333',
  },
  button: {
    backgroundColor: '#0066CC',
    padding: 10,
    borderRadius: 5,
    alignItems: 'center',
    marginTop: 20,
  },
  buttonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: 'bold',
  }
});
