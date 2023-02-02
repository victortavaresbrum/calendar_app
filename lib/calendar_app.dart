import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarApp extends StatefulWidget {
  const CalendarApp({super.key});

  @override
  State<CalendarApp> createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: SizedBox(
                width: size.width / 1.2,
                child: TableCalendar(
                  headerStyle: _buildHeaderStyle(),
                  calendarStyle: buildCalendarStyle(),
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  focusedDay: _focusedDay,
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  HeaderStyle _buildHeaderStyle() {
    return const HeaderStyle(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFF01A6E8),
            Color(0xFF014891),
          ],
        ),
      ),
    );
  }

  CalendarStyle buildCalendarStyle() {
    return const CalendarStyle(
      defaultTextStyle: TextStyle(fontSize: 16),
      disabledTextStyle: TextStyle(fontSize: 16),
      holidayTextStyle: TextStyle(
        fontSize: 16,
      ),
      weekNumberTextStyle: TextStyle(fontSize: 16),
      weekendTextStyle: TextStyle(fontSize: 16, color: Colors.grey),
      selectedDecoration: BoxDecoration(
          color: Color(0xFF01A6E8),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 138, 138, 138),
                blurRadius: 3,
                offset: Offset(0, 0),
                spreadRadius: 1)
          ]),
    );
  }
}
