import 'package:flutter/material.dart';
import 'package:receiptsapp/models/recipe-model.dart';
import 'package:receiptsapp/widgets/form-recipe.dart';
import 'package:receiptsapp/widgets/loading.dart';

class EditRecipe extends StatefulWidget {
  @override
  _EditRecipeState createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {

  RecipeModel recipe;
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var recipeArgument = ModalRoute.of(context).settings.arguments;

    setState(() {
      recipe = recipeArgument;
      loading = false;
    });

    if(loading){
        return Loading();
    }
    else{
      if(recipe == null){
        return Text('Algum erro ocorrey');
      }
      else{
        return Scaffold(
          backgroundColor: Colors.purple[500],
          appBar: AppBar(
            title: Text('Atualizando :  ${recipe.name}'),
            backgroundColor: Colors.purple[700],
          ),
          body: new FormRecipe(recipe: recipe),
        );
      }
    }

  }
}
