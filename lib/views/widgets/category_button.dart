import 'package:flutter/material.dart';

Widget categoryButton(
    int _selectedCategory, int index, String topic, Function categoryRefresh) {
  return InkWell(
    onTap: categoryRefresh,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: _selectedCategory == index
            ? Colors.red
            : Colors.red.withOpacity(0.25),
      ),
      alignment: Alignment.center,
      child: Text(
        topic,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
