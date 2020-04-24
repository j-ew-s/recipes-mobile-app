import 'package:flutter/material.dart';
import 'package:receiptsapp/models/recipe-model.dart';
import 'package:receiptsapp/widgets/form-recipe.dart';

class CreateReceipt extends StatefulWidget {
  @override
  _CreateReceiptState createState() => _CreateReceiptState();
}

class _CreateReceiptState extends State<CreateReceipt> {

  RecipeModel receipt = RecipeModel();
  
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
      body: FormRecipe(recipe: receipt),
    );
  }
}
