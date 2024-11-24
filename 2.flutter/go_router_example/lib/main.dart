import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'examples/loadmore_listview.dart';
import 'examples/sheduling_calendar.dart';
import 'examples/news_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/LoadMoreListV',
    routes: [
      StatefulShellRoute.indexedStack(
        builder:
            (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
         return ScaffoldNavBar(navigationShell: navigationShell);
                  },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/LoadMoreListV',
                name: 'LoadMoreListV',
                builder: (BuildContext context, GoRouterState state) => const LoadMoreListV(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'ShedulingCalendar/:id',
                    name: 'ShedulingCalendar',
                    builder: (BuildContext context, GoRouterState state) =>
                        ShedulingCalendar(id: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/NewsList',
                builder: (BuildContext context, GoRouterState state) => const NewsList(),               
              ),
            ],
          ),
        ],
      )
    ],
    redirect: (BuildContext context, state) {
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

class ScaffoldNavBar extends StatelessWidget {
  const ScaffoldNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Расписание преподавателей'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Расписание группы'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
