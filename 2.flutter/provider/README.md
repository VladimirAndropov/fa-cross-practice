# repo  Провайдер


## Roadmap

Чтобы приступить к этому уроку, нужно предварительно изучить по очереди:



- 2.flutter/statefull/statefull
- 2.flutter/flutter_calendar_view



## МЕтодичка

Рассмотрим пример провайдера

Есть две кнопки 

 одна задает переменную set
```
    ElevatedButton(
            onPressed: () {
              context.read<Counts>().add('18');
            },
            child: Icon(Icons.add)),
        SizedBox(
          width: 40,
        ),
     
```

```
другая получает - get

   ElevatedButton(
            onPressed: () {
              context.read<Counts>().remove();
            },
            child: Icon(Icons.remove)),
      ],
    );
```

Функции add remove прописаны в 2.flutter/provider/lib/main.dart

Оборачиваем провайдером все приложение сразу вначале

```
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counts()),
      ],
      child: MyApp(),
    ),
  );
}
```

Обратите внимание на разную доступность к переменным 

    context.watch<Counts>().count - 
    может только просматривать


    context.read<Counts>().add('18') -
     может редактировать

