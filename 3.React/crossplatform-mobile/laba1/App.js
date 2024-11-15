import React, { useState, useEffect } from 'react';
import {
  StyleSheet,
  Text,
  View,
  TextInput,
  Button,
  FlatList,
  TouchableOpacity,
  Modal,
  Alert,
  Linking,
  BackHandler,
  ToastAndroid
} from 'react-native';

export default function App() {

  useEffect(() => {
    // Добавляем обработчик кнопки "Назад"
    const backHandler = BackHandler.addEventListener(
      'hardwareBackPress',
      handleBackPress
    );

    // Убираем обработчик при размонтировании компонента
    return () => backHandler.remove();
  }, []);

  const [text, setText] = useState('');
  const [items, setItems] = useState([]);
  const [modalVisible, setModalVisible] = useState(false);

  const links = [
    { id: '1', title: 'Open Google', url: 'https://www.google.com' },
    { id: '2', title: 'Open React Native', url: 'https://reactnative.dev' },
    { id: '3', title: 'Call Support', url: 'tel:+123456789' },
  ];

  // Функция добавления нового элемента в первый список
  const addItem = () => {
    if (text.trim()) {
      setItems([...items, text]);
      setText('');
    }
  };

  // Функция открытия ссылки из второго списка
  const openURL = async (url) => {
    const supported = await Linking.canOpenURL(url);

    if (supported) {
      Linking.openURL(url);
    } else {
      Alert.alert("Can't handle this URL");
    }
  };

  // Рендеринг элемента первого списка
  const renderItem1 = ({ item }) => (
    <TouchableOpacity
      style={styles.listItem0}
      onPress={() => setModalVisible(true)}
    >
      <Text style={styles.listText}>{item}</Text>
    </TouchableOpacity>
  );

  // Рендеринг элемента второго списка (ссылки)
  const renderItem2 = ({ item }) => (
    <TouchableOpacity style={styles.listItem} onPress={() => openURL(item.url)}>
      <Text style={styles.listText}>{item.title}</Text>
    </TouchableOpacity>
  );

  // Обработчик кнопки "Назад"
  const handleBackPress = () => {
    Alert.alert(
      'BackHandler',
      'Тут обработали BackHandler. Выйти из приложения?',
      [
        { text: 'Не надо', style: 'cancel' },
        { text: 'Выйти', onPress: () => BackHandler.exitApp() },
      ],
      { cancelable: true }
    );
    return true; // Блокируем стандартное действие кнопки "Назад"
  };

  // Показываем уведомление (Toast)
  const showToast = () => {
    ToastAndroid.show('Это сообщение через ToastAndroid', ToastAndroid.SHORT);
  };

  // Показываем уведомление (Toast) с позиционированием
  const showToastWithPosition = () => {
    ToastAndroid.showWithGravity(
      'Toast with Gravity!',
      ToastAndroid.SHORT,
      ToastAndroid.CENTER
    );
  };

  return (
    <View style={styles.container}>
       <Text style={styles.subHeader}>Всплывающее окно через ToastAndroid</Text>
      <Button title="Показать" style={styles.t} onPress={showToast} />

      {/* Первый список: добавление элементов */}
      <Text style={styles.subHeader}>Какой-то список</Text>
      <TextInput
        style={styles.input}
        placeholder="Введите элемент"
        value={text}
        onChangeText={setText}
      />
      <Button title="Добавить" onPress={addItem} />
      <FlatList
        data={items}
        keyExtractor={(item, index) => index.toString()}
        renderItem={renderItem1}
      />

      {/* Второй список: ссылки */}
      <Text style={styles.subHeader}>Какие-то ссылки через supportedURL как в лабе</Text>
      <FlatList
        data={links}
        keyExtractor={(item) => item.id}
        renderItem={renderItem2}
      />

      {/* Модальное окно для первого списка */}
      <Modal
        visible={modalVisible}
        transparent={true}
        animationType="slide"
        onRequestClose={() => setModalVisible(false)}
      >
        <View style={styles.modal}>
          <Text style={styles.modalText}>Модальное окно</Text>
          <Button title="Закрыть" onPress={() => setModalVisible(false)} />
        </View>
      </Modal>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    paddingTop: 50,
    backgroundColor: '#f5f5f5',
  },
  header: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 20,
  },
  subHeader: {
    fontSize: 20,
    fontWeight: 'bold',
    marginVertical: 10,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 10,
    marginBottom: 10,
    borderRadius: 5,
    backgroundColor: '#fff',
  },
  listItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 10,
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
  },
  listItem0: {
    padding: 15,
    backgroundColor: '#d9d9d9',
    borderBottomWidth: 1,
    borderColor: '#ccc',
    marginVertical: 5,
    borderRadius: 5,
  },
  listText: {
    flex: 1,
    fontSize: 16,
  },
  modal: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(0,0,0,0.5)',
  },
  modalText: {
    fontSize: 20,
    marginBottom: 20,
    color: '#fff',
  },
  t: {
    paddingBottom: 50,
    paddingTop: 500
  }
});
