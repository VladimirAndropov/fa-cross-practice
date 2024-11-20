import 'dart:ui';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

// import 'pages/home_page.dart';

DateTime get _now => DateTime.now();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController()..addAll(_events),
      child: MaterialApp(
        title: 'Flutter Calendar Page Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        scrollBehavior: ScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.trackpad,
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        home: MobileHomePage(),
      ),
    );
  }
}

class MobileHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Calendar Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ElevatedButton(
            //   onPressed: () => context.pushRoute(MonthViewPageDemo()),
            //   child: Text("Month View"),
            // ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => context.pushRoute(DayViewPageDemo()),
              child: Text("Day View"),
            ),
            SizedBox(
              height: 20,
            ),
            // ElevatedButton(
            //   onPressed: () => context.pushRoute(WeekViewDemo()),
            //   child: Text("Week View"),
            // ),
          ],
        ),
      ),
    );
  }
}

class DayViewPageDemo extends StatefulWidget {
  const DayViewPageDemo({super.key});

  @override
  _DayViewPageDemoState createState() => _DayViewPageDemoState();
}

class _DayViewPageDemoState extends State<DayViewPageDemo> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 8,
          onPressed: (){},// => context.pushRoute(CreateEventPage()),
        ),
        body: DayViewWidget(),
      );
  }
}

class DetailsPage extends StatelessWidget {
  final CalendarEventData event;

  const DetailsPage({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: event.color,
        elevation: 0,
        centerTitle: false,
        title: Text(
          event.title,
          style: TextStyle(
            color: event.color.accentColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(
            Icons.arrow_back,
            color: event.color.accentColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text(
            "Date: ${event.date.dateToStringWithFormat(format: "dd/MM/yyyy")}",
          ),
          SizedBox(
            height: 15.0,
          ),
          if (event.startTime != null && event.endTime != null) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From"),
                      Text(
                        event.startTime
                                ?.getTimeInFormat(TimeStampFormat.parse_12) ??
                            "",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("To"),
                      Text(
                        event.endTime
                                ?.getTimeInFormat(TimeStampFormat.parse_12) ??
                            "",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
          if (event.description?.isNotEmpty ?? false) ...[
            Divider(),
            Text("Description"),
            SizedBox(
              height: 10.0,
            ),
            Text(event.description!),
          ],
          const SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    CalendarControllerProvider.of(context)
                        .controller
                        .remove(event);
                    Navigator.of(context).pop();
                  },
                  child: Text('Delete Event'),
                ),
              ),
              SizedBox(width: 30),
              // Expanded(
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       final result = await Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (_) => CreateEventPage(
              //             event: event,
              //           ),
              //         ),
              //       );

              //       if (result) {
              //         Navigator.of(context).pop();
              //       }
              //     },
              //     child: Text('Edit Event'),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}



class DayViewWidget extends StatelessWidget {
  final GlobalKey<DayViewState>? state;
  final double? width;

  const DayViewWidget({
    super.key,
    this.state,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return DayView(
      key: state,
      width: width,
      startDuration: Duration(hours: 8),
      showHalfHours: true,
      heightPerMinute: 3,
      timeLineBuilder: _timeLineBuilder,
      scrollPhysics: const BouncingScrollPhysics(),
      eventArranger: SideEventArranger(maxWidth: 30),
      hourIndicatorSettings: HourIndicatorSettings(
        color: Theme.of(context).dividerColor,
      ),
      onTimestampTap: (date) {
        SnackBar snackBar = SnackBar(
          content: Text("On tap: ${date.hour} Hr : ${date.minute} Min"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onEventTap: (events, date) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsPage(
              event: events.first,
            ),
          ),
        );
      },
      onEventLongTap: (events, date) {
        SnackBar snackBar = SnackBar(content: Text("on LongTap"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      halfHourIndicatorSettings: HourIndicatorSettings(
        color: Theme.of(context).dividerColor,
        lineStyle: LineStyle.dashed,
      ),
      verticalLineOffset: 0,
      timeLineWidth: 65,
      showLiveTimeLineInAllDays: true,
      liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
        color: Colors.redAccent,
        showBullet: false,
        showTime: true,
        showTimeBackgroundView: true,
      ),
    );
  }


  Widget _timeLineBuilder(DateTime date) {
    if (date.minute != 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            top: -8,
            right: 8,
            child: Text(
              "${date.hour}:${date.minute}",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black.withAlpha(50),
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    }

    final hour = ((date.hour - 1) % 12) + 1;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          top: -8,
          right: 8,
          child: Text(
            "$hour ${date.hour ~/ 12 == 0 ? "am" : "pm"}",
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

List<CalendarEventData> _events = [
  CalendarEventData(
    date: _now,
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 1)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 3)),
    startTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
    endTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        14),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        16),
    title: "Team Meeting",
    description: "Team Meeting",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        10),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        12),
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
  ),
];