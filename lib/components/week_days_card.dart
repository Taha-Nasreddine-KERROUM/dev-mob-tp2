import 'package:flutter/material.dart';

class WeekDaysCard extends StatelessWidget {
  final String day;

  const WeekDaysCard({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      margin: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.amber,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                day,
                style: TextStyle(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {},
                  color: Colors.orange,
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}