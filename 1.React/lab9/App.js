import React from 'react';
import { ActionSheetIOS, Button, StyleSheet, Text, View, SafeAreaView, ScrollView, FlatList, TouchableOpacity, Linking } from 'react-native';

const ruzUrl = 'https://ruz.fa.ru/ruz/main';

const mainUrl = 'https://org.fa.ru/';

export default function App() {
  const [resultLogs, setResultLogs] = React.useState([]);
  const [isVisibleLogs, setIsVisibleLogs] = React.useState(false);

  Date.prototype.timeNow = function () {
    return ((this.getHours() < 10)?"0":"") + this.getHours() +":"+ ((this.getMinutes() < 10)?"0":"") + this.getMinutes() +":"+ ((this.getSeconds() < 10)?"0":"") + this.getSeconds();
}

  const onPressSelectButton = () =>
    ActionSheetIOS.showActionSheetWithOptions(
      {
        options: ['Отменить', 'Расписание', 'Главная', 'Сбросить'],
        destructiveButtonIndex: 3,
        cancelButtonIndex: 0,
        userInterfaceStyle: 'dark',
      },
      buttonIndex => {
        if (buttonIndex === 0) {
        } else if (buttonIndex === 1) {
          onSelect(ruzUrl);
        } else if (buttonIndex === 2) {
          onSelect(mainUrl);
        } else {
          setResultLogs([]);
        }
      },
    );

    const onSelect = (url) => {
      let logMap = new Map();
      logMap.set('date', new Date().timeNow());
      logMap.set('url', url);
      setResultLogs([...resultLogs, logMap]);
      Linking.openURL(url);
    };

  const changeLogVisibility = () => {
    setIsVisibleLogs(!isVisibleLogs);
  }

  const openURL = (link) => {
    Linking.openURL(link);
  }

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.button}>Пример IOS дизайна прилы</Text>

      <Button
        onPress={onPressSelectButton}
        title="Нажми на меня"
        accessibilityLabel="Открыть ссылку"
        style={styles.button}
      />


      <TouchableOpacity onPress={changeLogVisibility} style={styles.logToggleBtn}>
        <Text>{isVisibleLogs ? 'Скрыть историю запросов' : 'Показать историю запросов'}</Text>
      </TouchableOpacity>

      {isVisibleLogs && (
        <View style={styles.logsContainer}>
        <FlatList

          data={resultLogs}
          renderItem={({ item }) => (
            <TouchableOpacity onPress={() => openURL(item.get('url'))} style={styles.listItem}>
              <Text style={styles.listText}><Text style={{backgroundColor: "lightblue"}}>{item.get('date') + ''}</Text> - {item.get('url')}</Text>
            </TouchableOpacity>
          )}
          ItemSeparatorComponent={() => <View style={styles.separator} />}
        />
      </View>
    )}

    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  button: {
    marginVertical: 20,
  },
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'flex-start',
  },
  logToggleBtn: {
    marginTop: 20,
    paddingVertical: 10,
    paddingHorizontal: 20,
    // color: "lightblue",
    backgroundColor: '#f0f0f0',
    borderRadius: 5,
  },
  logsContainer: {
    width: '100%',
    height: 200,
    marginTop: 20,
    // borderTopWidth: 1,
    alignItems: 'center',
    borderTopColor: '#ccc',
  },rBottomColor: '#ccc',

  listItem: {
    padding: 10,
    borderBottomWidth: 1,
    borderBottomColor: '#ccc',
  },
  listText: {
    fontSize: 16,
  },
  separator: {
    height: 1,
  },
});