import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'examples/prepods_list.dart';
import 'examples/sheduling_calendar.dart';
import 'examples/group_list.dart';
import 'examples/group_list_body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/PrepodsList',
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
                path: '/PrepodsList',
                name: 'PrepodsList',
                builder: (BuildContext context, GoRouterState state) => const PrepodsList(),
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
                path: '/GroupList',
                name: 'GroupList',
                builder: (BuildContext context, GoRouterState state) => const GroupList(),               
                routes: <RouteBase>[
                  GoRoute(
                    path: 'GroupListBody/:thisselectedCategory',
                    name: 'GroupListBody',
                    builder: (BuildContext context, GoRouterState state) =>
                        GroupListBody(thisselectedCategory: state.pathParameters['thisselectedCategory']),
                  ),
                ],
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
