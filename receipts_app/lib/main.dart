import 'package:flutter/material.dart';
import 'package:receiptsapp/screens/create-recipe.dart';
import 'package:receiptsapp/screens/detail-recipe.dart';
import 'package:receiptsapp/screens/edit-recipe.dart';
import 'package:receiptsapp/screens/home.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/' : (context) => Home(),
      '/create-recipe' : (context) => CreateRecipe(),
      '/detail-recipe' : (context) => DetailRecipe(),
      '/edit-recipe' : (context) => EditRecipe(),
    },
  ));
}
