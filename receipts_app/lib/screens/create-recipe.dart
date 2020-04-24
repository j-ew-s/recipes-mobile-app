import 'package:flutter/material.dart';
import 'package:receiptsapp/models/recipe-model.dart';
import 'package:receiptsapp/widgets/form-recipe.dart';

class CreateRecipe extends StatefulWidget {
  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {

  RecipeModel recipe = RecipeModel();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[500],
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              icon: Icon(
                Icons.cancel
              ),
              label: Text('Cancel')),
        ],
      ),
      body: FormRecipe(recipe: recipe),
    );
  }
}
