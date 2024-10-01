import React from 'react';
import { Text, SafeAreaView, StyleSheet, View, ScrollView, Image } from 'react-native';
import { Card } from 'react-native-paper';

const App = () => {
    return (
        <SafeAreaView style={styles.container}>
            <ScrollView>
                <Text style={styles.title}>Курс на яркую жизнь!</Text>
                <Text style={styles.subtitle}>
                    Журнал, вдохновляющий ставить яркие цели и идти к ним. (18+)
                </Text>
                <View style={styles.buttonContainer}>
                    <Text style={styles.button}>Get notifications</Text>
                </View>
                <View style={styles.cardContainer}>
                    <Card style={styles.card}>
                        <Image
                            source={{ uri: 'https://via.placeholder.com/150' }}
                            style={styles.image}
                        />
                        <Text style={styles.cardTitle}>
                            Мотивацию в студию: поддерживающие фразы для этой осени
                        </Text>
                        <Text style={styles.cardContent}>
                            Все мы время от времени нуждаемся в поддержке и мотивации...
                        </Text>
                    </Card>
                    <Card style={styles.card}>
                        <Image
                            source={{ uri: 'https://via.placeholder.com/150' }}
                            style={styles.image}
                        />
                        <Text style={styles.cardTitle}>
                            Четыре рабочих способа создать хорошее впечатление
                        </Text>
                        <Text style={styles.cardContent}>
                            Существует огромное количество различных ситуаций...
                        </Text>
                    </Card>
                    <Card style={styles.card}>
                        <Image
                            source={{ uri: 'https://via.placeholder.com/150' }}
                            style={styles.image}
                        />
                        <Text style={styles.cardTitle}>
                            Техника 10-10-10: как принять решение и его последствия?
                        </Text>
                        <Text style={styles.cardContent}>
                            Решения, которые мы принимаем на протяжении всей нашей жизни...
                        </Text>
                    </Card>
                </View>
            </ScrollView>
        </SafeAreaView>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
        padding: 16,
    },
    title: {
        fontSize: 32,
        fontWeight: 'bold',
        textAlign: 'center',
        marginVertical: 16,
    },
    subtitle: {
        fontSize: 18,
        textAlign: 'center',
        marginBottom: 16,
    },
    buttonContainer: {
        alignItems: 'center',
        marginBottom: 16,
    },
    button: {
        backgroundColor: '#007bff',
        color: '#fff',
        paddingVertical: 8,
        paddingHorizontal: 16,
        borderRadius: 4,
    },
    cardContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    card: {
        width: '30%',
        padding: 8,
    },
    image: {
        width: '100%',
        height: 100,
        marginBottom: 8,
    },
    cardTitle: {
        fontSize: 16,
        fontWeight: 'bold',
        marginBottom: 4,
    },
    cardContent: {
        fontSize: 14,
    },
});

export default App;
