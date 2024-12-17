# netbloc - Пример асинхронной загрузки данных с ruz.fa.ru


## Roadmap

Чтобы приступить к этому уроку, нужно предварительно изучить по очереди:



- 2.flutter/statefull/statefull
- 2.flutter/flutter_calendar_view
- 2.flutter/provider
- 2.flutter/news_list




Используется  рассмотреный bloc 2.flutter/flbloc/flbloc/README.md

## Методичка

Создайте приложение

в нем создайте виджет

```dart
ListView.builder(
                  itemCount: state.loadedusers.length,
                    itemBuilder: (context, index) =>
                        Container(
                            child: ListTile(
                                  leading: Text(state.loadedusers[index].id),
                                    title: Row(
                                      children: <Widget>[
                                        Text(state.loadedusers[index].label), 
                                        Text(state.loadedusers[index].description), 
                                        Text(state.loadedusers[index].type),
                                      ]
                                    )
                                )
                                )                                
                );
```

В этом виджете мы загружаем список пользователей state.loadedusers в виджет, чтобы отобразить его

Но мы его ещё не создали!

Создадим объет Юзер в 2.flutter/netbloc/netbloc/lib/models/user.dart

И создадим Обработчик запросов для сайта в файле

2.flutter/netbloc/netbloc/lib/services/user_api_provider.dart

Попробуйте загрузить список getUsers сразу в виджет - у вас ничего не выйдет

Чтобы загрузить наш список в виджет, этот виджет нужно обернуть в провайдер

Смотрите пример Провайдера отдельно в 
2.flutter/provider/README.md

Провайдер предоставит переменные для виджетов, в которые он обернут, те есть смысл обернуть провайдером все приложение сразу
строка 31 в 2.flutter/netbloc/netbloc/lib/main.dart

    BlocProvider<UserBloc>

А чтобы запросы обрабатывались без последствий для виджета, провайдер дополнительно оборачивают в репозиторий - 

2.flutter/netbloc/netbloc/lib/services/users_repository.dart

Репозиторий занимается тем, что обрабатывает ошибки api
и если он вылетит из-за проблем с апи, то виджет продолжит работу

Так как функция загрузки данных асинхронная, то используется bloc
2.flutter/netbloc/netbloc/lib/bloc/user_bloc.dart

Наш виджет оборачиается в блок 2.flutter/netbloc/netbloc/lib/widgets/users_list.dart

строка 9

    BlocBuilder<UserBloc,UserState>






