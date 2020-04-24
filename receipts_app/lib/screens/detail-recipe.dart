import 'package:flutter/material.dart';
import 'package:receiptsapp/models/recipe-model.dart';
import 'package:receiptsapp/screens/delete-confirmation-recipe.dart';
import 'package:receiptsapp/widgets/loading.dart';

class DetailReceipt extends StatefulWidget {

  @override
  _DetailReceiptState createState() => _DetailReceiptState();
}

class _DetailReceiptState extends State<DetailReceipt> {

  RecipeModel receipt;
  String id;

  @override
  Widget build(BuildContext context) {

    void _showSettings(String id){

      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: DeleteConfirmationReceipt(id: id),
        );
      });

    }


   var passedArgument = ModalRoute.of(context).settings.arguments;

   if(passedArgument != null){
     receipt = passedArgument;
   }
   else{
     List<String> aa = new List<String>();
     receipt = RecipeModel(tags: aa , rate: 0, link: '', description: '', name: '', id: '');
   }

   if(receipt == null){
     return Loading();
   }
   else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[700],
          title: Text('${receipt.name} details'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.edit,
                color: Colors.white ,
                ),
              onPressed: (){
                Navigator.pushNamed(context, '/edit-recipe', arguments:  receipt
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
               _showSettings(receipt.id);
              },
              label: Text(''),
            )
          ],
        ),
        body: Column(
            children: <Widget>[

              Container(
                child: Text('${receipt.name}'),
              ),

              Container(
                child: Text('${receipt.description}'),
              ),

              Container(
                child: Text('${receipt.link}'),
              ),

              Container(
                child: Text('${receipt.rate}'),
              ),

            ],
          ),
        );
     }
  }
}
