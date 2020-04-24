import 'package:flutter/material.dart';
import 'package:receiptsapp/models/recipe-model.dart';
import 'package:receiptsapp/screens/delete-confirmation-recipe.dart';
import 'package:receiptsapp/widgets/loading.dart';

class DetailRecipe extends StatefulWidget {

  @override
  _DetailRecipeState createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {

  RecipeModel recipe;
  String id;

  @override
  Widget build(BuildContext context) {

    void _showSettings(String id){

      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: DeleteConfirmationRecipe(id: id),
        );
      });

    }


   var passedArgument = ModalRoute.of(context).settings.arguments;

   if(passedArgument != null){
     recipe = passedArgument;
   }
   else{
     List<String> aa = new List<String>();
     recipe = RecipeModel(tags: aa , rate: 0, link: '', description: '', name: '', id: '');
   }

   if(recipe == null){
     return Loading();
   }
   else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[700],
          title: Text('${recipe.name} details'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.edit,
                color: Colors.white ,
                ),
              onPressed: (){
                Navigator.pushNamed(context, '/edit-recipe', arguments:  recipe
                );
              },
              label: Text(''),
            ),

            FlatButton.icon(
              icon: Icon(
                Icons.restore_from_trash,
                color: Colors.red[300] ,
              ),
              onPressed: (){
               _showSettings(recipe.id);
              },
              label: Text(''),
            )
          ],
        ),
        body: Column(
            children: <Widget>[

              Container(
                child: Text('${recipe.name}'),
              ),

              Container(
                child: Text('${recipe.description}'),
              ),

              Container(
                child: Text('${recipe.link}'),
              ),

              Container(
                child: Text('${recipe.rate}'),
              ),

            ],
          ),
        );
     }
  }
}
