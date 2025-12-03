import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_planner/components/week_days_card.dart';
import 'package:meal_planner/models/meal.dart';
import 'package:meal_planner/models/meals_of_a_day_meals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<MealsOfADay> dayMealsBox;

  final List<MealsOfADay> weekDaysList = [
    MealsOfADay(
      day: 'Saturday',
      listOfMealsForADay: [
        Meal(
          name: 'Pancakes',
          imgPath: 'assets/images/pan.jpg',
          listOfIngredient: ['potato', 'zucchini', 'flour', 'egg', 'egg wash', 'dipping sauce'],
          identifier: 'sat_breakfast',
        ),
      ],
    ),
    MealsOfADay(
      day: 'Sunday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Monday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Tuesday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Wednesday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Thursday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Friday',
      listOfMealsForADay: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    dayMealsBox = await Hive.openBox<MealsOfADay>('MealsBDD');

    if (dayMealsBox.isEmpty) {
      for (var e in weekDaysList) {
        await dayMealsBox.put(e.day, e);
      }
    }

    setState(() {});
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
              (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  @override
  void dispose() {
    dayMealsBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: signOut,
          ),
        ],
        title: Center(
          child: Text(
            "Home page",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: dayMealsBox.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dayMealsBox.length,
        itemBuilder: (context, index) {
          final day = dayMealsBox.keys.elementAt(index);
          final mealsOfDay = dayMealsBox.get(day);

          return mealsOfDay != null
              ? WeekDaysCard(dayAndItsMealsList: mealsOfDay)
              : SizedBox.shrink();
        },
      ),
    );
  }
}