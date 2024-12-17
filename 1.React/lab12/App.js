import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, ImageBackground, FlatList, Share, Linking } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import Icon from 'react-native-vector-icons/Ionicons';

const HomeScreen = ({ navigation }) => {
  const contacts = [
    { id: '1', firstName: 'Осел', lastName: '', phone: '+7 999 123-45-67', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Shrek_Esel_auf_dem_Eselsbrunnen_in_Halle_Saale_-_Alter_Markt_Stra%C3%9Fenkunst_-_panoramio.jpg/640px-Shrek_Esel_auf_dem_Eselsbrunnen_in_Halle_Saale_-_Alter_Markt_Stra%C3%9Fenkunst_-_panoramio.jpg' },
    { id: '2', firstName: 'Шрек', lastName: 'Шреков', phone: '+7 999 765-43-21', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Shrek_Madame_Tussauds_London.jpg/640px-Shrek_Madame_Tussauds_London.jpg' },
    { id: '3', firstName: 'Кот', lastName: 'Сапогов', phone: '+7 999 111-22-33', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Puss_in_Boots%2C_2011%2C_Australia-5.jpg/640px-Puss_in_Boots%2C_2011%2C_Australia-5.jpg' },
  ];

  const renderContactItem = ({ item }) => {
    return (
      <TouchableOpacity
        style={styles.contactItem}
        onPress={() =>
          navigation.navigate('Profile', {
            id: item.id,
            firstName: item.firstName,
            lastName: item.lastName,
            phone: item.phone,
            image: item.image,
          })
        }
      >
        <Text style={[styles.firstName, item.lastName && styles.boldFirstName]}>
          {item.firstName} {item.lastName && (
        <Text style={[styles.firstName]}>
        { item.lastName}
        </Text>
  )}
        </Text>
      </TouchableOpacity>
    );
  };

  return (
    <View style={styles.container}>
      <FlatList
        data={contacts}
        keyExtractor={(item) => item.id}
        renderItem={renderContactItem}
        ItemSeparatorComponent={() => <View style={styles.separator} />}
      />
    </View>
  );
};


const ProfileScreen = ({ route }) => {
  const { id, firstName, lastName, phone, image } = route.params;
  const handleSendMessage = (phone) => {
    const url = `sms:${phone}`;
    Linking.openURL(url);
  };

  const handleShareContact = (firstName, phone) => {
    Share.share({
      message: `Контакт: ${firstName}, Телефон: ${phone}`,
    });
  };
  return (
    <View style={styles.profileContainer}>
      <ImageBackground
        source={{ uri: image }}
        resizeMode="cover"
        style={styles.backgroundImage}
      > 
      
      {/* Profile information */}
      <View style={styles.overlay}>
          <Text style={[styles.title, { flexDirection: 'row' }]}>
            {firstName}{' '}{lastName}
            
          </Text>
          <Text style={styles.field}>{phone}</Text>
        </View>

        <View style={styles.spacer} />

         {/* Add buttons at the bottom */}
         <View style={styles.buttonContainer}>
          <TouchableOpacity style={[styles.shareButton, styles.buttonWrapper]} onPress={() => handleShareContact(firstName, phone)}>
            <Icon name="share-social-outline" size={24} color="#fff" />
            <Text style={styles.buttonText}>Share</Text>
          </TouchableOpacity>
          <TouchableOpacity style={[styles.callButton, styles.buttonWrapper]} onPress={() => handleSendMessage(phone)}>
            <Icon name="chatbubble-outline" size={24} color="#fff" />
            <Text style={styles.buttonText}>Message</Text>
          </TouchableOpacity>
        </View>
      </ImageBackground>
    </View>
  );
};

const Stack = createNativeStackNavigator();

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} options={{ title: 'Contacts' }} />
        <Stack.Screen name="Profile" component={ProfileScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default App;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
  },
  contactItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 8,
  },
  backgroundImage: {
    width: '100%',
    height: '70%',
    resizeMode: 'cover',
  },
  
  firstName: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  boldFirstName: {
    fontWeight: 'normal',
  },
  lastName: {
    fontSize: 16,
    color: '#666',
  },
  boldLastName: {
    fontWeight: 'bold',
    marginLeft: 4,
  },
  phone: {
    fontSize: 16,
    color: '#666',
  },
  separator: {
    height: 1,
    backgroundColor: '#ccc',
    marginVertical: 8,
  },
  profileContainer: {
    flex: 1,
    padding: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 16,
    color: '#fff',
    
  },
  field: {
    fontSize: 18,
    marginBottom: 4,
    color: '#fff',
  },
  overlay: {
    // flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    padding: 8,
  },
   // New styles for buttons
   buttonContainer: {
    // backgroundColor: 'rgba(0, 0, 0, 0.5)',
    flex: 1,
    // justifyContent: 'flex-end',
    flexDirection: 'row',
    // justifyContent: 'start',
    // alignItems: 'bottom',
    paddingHorizontal: 16,
    marginTop: 16, // Add some space between buttons and profile info
  },

 
  buttonWrapper: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: 10,
    paddingHorizontal: 16,
    borderRadius: 20,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    height: 'auto', // This will make it adjust to content height
    maxHeight: 60, // Maximum height (adjust as needed)
    minHeight: 40, // Minimum height (adjust as needed)
  },
  spacer: {
    height: '35%',
    width: '100%',
  },

  shareButton: {
    marginRight: 8,
  },
  callButton: {
    marginLeft: 8,
  },

  buttonText: {
    fontSize: 14,
    marginTop: 4,
    color: '#fff',
  },
  // shareButton: {
  //   flex: 1,
  //   justifyContent: 'center',
  //   alignItems: 'center',
  // },
  // callButton: {
  //   flex: 1,
  //   justifyContent: 'center',
  //   alignItems: 'center',
  // },
  // buttonText: {
  //   fontSize: 14,
  //   marginTop: 4,
  //   color: '#fff',
  // },
});
