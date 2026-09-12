# nested_router - Навигация и роутинг

## Roadmap

нужно  изучить по очереди:



- 2.flutter/statefull/statefull
- 2.flutter/flutter_calendar_view
- 2.flutter/provider
- 2.flutter/news_list
- 2.flutter/netbloc/netbloc
- 2.flutter/time_scheduler_table
- 2.flutter/flbloc/flbloc
- 2.flutter/searchable_list/searcheable_list


Чтобы переключать виджеты между собой, существует библиотека router_go

В данном примере мы создали 2 виджета

    DetailPage и TabB

а чтобы переключаться между ними или внутри одного запускать другой, прописали роуты

Второй является вложенным и поэтому его путь будет /main/details

```
GoRoute(
                path: '/main',
                builder: (BuildContext context, GoRouterState state) => const MyHomePage(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) =>
                        const DetailPage('from Main Page'),
                  ),
                ],
              ),
```

используем функцию

    (onPressed: () => context.go('/main')

для перехода на соответствующий виджет Здесь вызовется MyHomePage
а при вызове

    (onPressed: () => context.go('details')

Будет вызвана DetailPage('from Main Page')
