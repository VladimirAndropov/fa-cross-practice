import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  FlatList,
  TouchableOpacity,
  StyleSheet,
  TextInput,
  BackHandler,
  Share,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const App = () => {
  const [selectedContact, setSelectedContact] = useState(null);
  const [screenStack, setScreenStack] = useState(['contacts']); // Стек экранов
  const [messages, setMessages] = useState({}); // Хранилище сообщений для каждого контакта
  const [currentMessage, setCurrentMessage] = useState('');

  const contacts = [
    { id: '1', name: 'Иван Иванов', phone: '+123456789' },
    { id: '2', name: 'Мария Смирнова', phone: '+987654321' },
    { id: '3', name: 'Петр Петров', phone: '+192837465' },
  ];

  const currentScreen = screenStack[screenStack.length - 1];

  useEffect(() => {
    const handleBackPress = () => {
      if (screenStack.length > 1) {
        const newStack = [...screenStack];
        newStack.pop();
        setScreenStack(newStack);
        if (newStack[newStack.length - 1] === 'contacts') {
          setSelectedContact(null);
        }
        return true; // Обработано
      }
      return false; // Вернуться к системной обработке
    };

    const backHandler = BackHandler.addEventListener(
      'hardwareBackPress',
      handleBackPress
    );

    return () => backHandler.remove();
  }, [screenStack]);

  const navigateTo = (screen, contact = null) => {
    setScreenStack([...screenStack, screen]);
    if (contact) setSelectedContact(contact);
  };

  const handleCall = () => navigateTo('call');

  const handleSendMessage = () => {
    if (!currentMessage.trim()) return;
    const contactMessages = messages[selectedContact.id] || [];
    setMessages({
      ...messages,
      [selectedContact.id]: [...contactMessages, { text: currentMessage, isUser: true }],
    });
    setCurrentMessage('');
  };

  const handleBack = () => {
    if (screenStack.length > 1) {
      const newStack = [...screenStack];
      newStack.pop();
      setScreenStack(newStack);
      if (newStack[newStack.length - 1] === 'contacts') {
        setSelectedContact(null);
      }
    }
  };

  const handleShare = async () => {
    try {
      const result = await Share.share({
        message: `Контакт: ${selectedContact.name}, Телефон: ${selectedContact.phone}`,
      });
      if (result.action === Share.sharedAction) {
        alert('Контакт успешно отправлен!');
      }
    } catch (error) {
      alert('Не удалось поделиться контактом.');
    }
  };

  return (
    <View style={styles.container}>
      {/* Список контактов */}
      {currentScreen === 'contacts' && (
        <View style={styles.contactsList}>
          <Text style={styles.header}>Список контактов</Text>
          <FlatList
            data={contacts}
            keyExtractor={(item) => item.id}
            renderItem={({ item }) => (
              <TouchableOpacity
                style={styles.contactItem}
                onPress={() => navigateTo('profile', item)}
              >
                <View style={styles.contactInfo}>
                  <View style={styles.avatar}>
                    <Text style={styles.avatarText}>{item.name.charAt(0)}</Text>
                  </View>
                  <View>
                    <Text style={styles.contactName}>{item.name}</Text>
                    <Text style={styles.contactPhone}>{item.phone}</Text>
                  </View>
                </View>
              </TouchableOpacity>
            )}
          />
        </View>
      )}

      {/* Страница контакта */}
      {currentScreen === 'profile' && selectedContact && (
        <View style={styles.contactDetails}>
          <View style={styles.contactHeader}>
            <View style={styles.avatar}>
              <Text style={styles.avatarText}>
                {selectedContact.name.charAt(0)}
              </Text>
            </View>
            <Text style={styles.contactName}>{selectedContact.name}</Text>
            <Text style={styles.contactPhone}>Мобильный {selectedContact.phone}</Text>
          </View>
          <View style={styles.actionIcons}>
            <TouchableOpacity style={styles.iconButton} onPress={handleCall}>
              <Ionicons name="call" size={30} color="#4CAF50" />
              <Text style={styles.iconText}>Позвонить</Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.iconButton}
              onPress={() => navigateTo('messages')}
            >
              <Ionicons name="chatbubble" size={30} color="#2196F3" />
              <Text style={styles.iconText}>Сообщение</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.iconButton} onPress={handleShare}>
              <Ionicons name="share-social" size={30} color="#FFC107" />
              <Text style={styles.iconText}>Поделиться</Text>
            </TouchableOpacity>
          </View>
          <View style={styles.additionalInfo}>
            <TouchableOpacity style={styles.additionalButton}>
              <Text style={styles.additionalText}>WhatsApp</Text>
              <Ionicons name="logo-whatsapp" size={20} color="#4CAF50" />
            </TouchableOpacity>
            <TouchableOpacity style={styles.additionalButton}>
              <Text style={styles.additionalText}>Telegram</Text>
              <Ionicons name="paper-plane" size={20} color="#2196F3" />
            </TouchableOpacity>
          </View>
        </View>
      )}

      {/* Экран звонка */}
      {currentScreen === 'call' && selectedContact && (
        <View style={styles.callScreen}>
          <View style={styles.contactHeader}>
            <View style={styles.avatar}>
              <Text style={styles.avatarText}>
                {selectedContact.name.charAt(0)}
              </Text>
            </View>
            <Text style={styles.contactName}>{selectedContact.name}</Text>
            <Text style={styles.contactPhone}>Мобильный {selectedContact.phone}</Text>
          </View>
          <Text style={styles.callingText}>Вызов...</Text>
        </View>
      )}

      {/* Экран сообщений */}
      {currentScreen === 'messages' && selectedContact && (
        <View style={styles.messagesScreen}>
          <View style={styles.messageHeader}>
            <TouchableOpacity onPress={handleBack}>
              <Ionicons name="arrow-back" size={24} color="#007bff" />
            </TouchableOpacity>
            <Text style={styles.messageHeaderText}>{selectedContact.name}</Text>
          </View>
          <FlatList
            data={messages[selectedContact.id] || []}
            keyExtractor={(_, index) => index.toString()}
            renderItem={({ item }) => (
              <View
                style={[
                  styles.messageBubble,
                  item.isUser ? styles.userBubble : styles.contactBubble,
                ]}
              >
                <Text style={styles.messageText}>{item.text}</Text>
              </View>
            )}
            style={styles.messagesList}
          />
          <View style={styles.inputContainer}>
            <TextInput
              value={currentMessage}
              onChangeText={setCurrentMessage}
              placeholder="Введите сообщение"
              style={styles.input}
            />
            <TouchableOpacity style={styles.sendButton} onPress={handleSendMessage}>
              <Ionicons name="send" size={24} color="#fff" />
            </TouchableOpacity>
          </View>
        </View>
      )}
    </View>
  );
};

// Стилизация (см. предыдущее сообщение)
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  // Список контактов
  contactsList: {
    flex: 1,
    paddingTop: 40,
    padding: 10,
  },
  header: {
    fontSize: 22,
    fontWeight: 'bold',
    marginBottom: 15,
    textAlign: 'center',
  },
  contactItem: {
    backgroundColor: '#ffffff',
    padding: 15,
    marginBottom: 10,
    borderRadius: 8,
    flexDirection: 'row',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOpacity: 0.1,
    shadowRadius: 5,
    shadowOffset: { width: 0, height: 2 },
    elevation: 2,
  },
  contactInfo: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  avatar: {
    backgroundColor: '#007bff',
    width: 50,
    height: 50,
    borderRadius: 25,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 15,
  },
  avatarText: {
    color: '#fff',
    fontSize: 20,
    fontWeight: 'bold',
  },
  contactName: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  contactPhone: {
    fontSize: 14,
    color: '#555',
  },
  // Детали контакта
  contactDetails: {
    paddingTop: 40,
    flex: 1,
    paddingHorizontal: 20,
    alignItems: 'center',
  },
  contactHeader: {
    alignItems: 'center',
    marginTop: 20,
    marginBottom: 30,
  },
  actionIcons: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    width: '100%',
    marginVertical: 20,
  },
  iconButton: {
    alignItems: 'center',
  },
  iconText: {
    marginTop: 5,
    fontSize: 12,
    color: '#555',
  },
  additionalInfo: {
    width: '100%',
  },
  additionalButton: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
  },
  additionalText: {
    fontSize: 16,
  },
  backButton: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 20,
  },
  backButtonText: {
    color: '#007bff',
    fontSize: 16,
    marginLeft: 5,
  },
   // Звонок
   callScreen: { flex: 1, justifyContent: 'center', alignItems: 'center' },
   callingText: { fontSize: 22, color: '#888', marginTop: 20 },
   // Сообщения
  messagesScreen: { flex: 1 },
  messagesList: { flex: 1 },
  messageBubble: { padding: 10, borderRadius: 15, margin: 10 },
  userBubble: { alignSelf: 'flex-end', backgroundColor: '#007bff' },
  contactBubble: { alignSelf: 'flex-start', backgroundColor: '#e5e5e5' },
  messageText: { color: '#fff' },
  inputContainer: { flexDirection: 'row', padding: 10, backgroundColor: '#fff' },
  input: { flex: 1, borderWidth: 1, borderColor: '#ddd', borderRadius: 8, padding: 10 },
  sendButton: { marginLeft: 10, backgroundColor: '#007bff', padding: 10, borderRadius: 8 },
  messageHeader: {
    paddingTop: 50,
    flexDirection: 'row',
    alignItems: 'center',
    padding: 15,
    backgroundColor: '#fff',
    elevation: 2,
  },
  messageHeaderText: {
    fontSize: 18,
    fontWeight: 'bold',
    marginLeft: 10,
  },
});

export default App;
