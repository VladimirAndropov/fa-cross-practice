# nested_router - Навигация и роутинг

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
