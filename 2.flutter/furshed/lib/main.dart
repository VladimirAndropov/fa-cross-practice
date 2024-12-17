import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'examples/prepods_list.dart';
import 'examples/sheduling_calendar.dart';



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
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                // path: '/ShedulingCalendar/:id',
                path: '/ShedulingCalendar',
                    name: 'ShedulingCalendar',
                    builder: (BuildContext context, GoRouterState state) =>
                        // ShedulingCalendar(id: state.pathParameters['id']),     
                        ShedulingCalendar(id: '8487e5d1-d82e-11e8-b636-005056bf5929' ),
                                
                // routes: <RouteBase>[
                //   GoRoute(
                //     path: 'GroupListBody/:thisselectedCategory',
                //     name: 'GroupListBody',
                //     builder: (BuildContext context, GoRouterState state) =>
                //         GroupListBody(thisselectedCategory: state.pathParameters['thisselectedCategory']),
                //   ),
                // ],
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
          BottomNavigationBarItem(icon: Icon(Icons.table_rows_rounded), label: 'Список'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Календарь'),
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
