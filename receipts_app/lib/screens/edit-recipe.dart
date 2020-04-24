import 'package:flutter/material.dart';
import 'package:receiptsapp/models/recipe-model.dart';
import 'package:receiptsapp/widgets/form-recipe.dart';
import 'package:receiptsapp/widgets/loading.dart';

class EditReceipt extends StatefulWidget {
  @override
  _EditReceiptState createState() => _EditReceiptState();
}

class _EditReceiptState extends State<EditReceipt> {

  RecipeModel receipt;
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var receiptArgument = ModalRoute.of(context).settings.arguments;

    setState(() {
      receipt = receiptArgument;
      loading = false;
    });

    if(loading){
        return Loading();
    }
    else{
      if(receipt == null){
        return Text('Algum erro ocorrey');
      }
      else{
        return Scaffold(
          backgroundColor: Colors.purple[500],
          appBar: AppBar(
            title: Text('Atualizando :  ${receipt.name}'),
            backgroundColor: Colors.purple[700],
          ),
          body: new FormReceipt(receipt: receipt),
        );
      }
    }

  }
}
