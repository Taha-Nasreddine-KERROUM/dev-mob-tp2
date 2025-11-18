import 'package:flutter/material.dart';
import 'package:meal_planner/components/week_days_card.dart';

class HomeScreen extends StatelessWidget {
  final List<String> weekDaysList;

  const HomeScreen({
    super.key,
    required this.weekDaysList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          ),
        ],
        title: Center(
          child: Text(
            "Home page",
            style: TextStyle(),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: weekDaysList.length,
        itemBuilder: (context, index) {
          return WeekDaysCard(day: weekDaysList[index]);
        },
      ),
    );
  }
}