import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receiptsapp/services/receipt-service.dart';

class DeleteConfirmationReceipt extends StatefulWidget {
  String id;
  DeleteConfirmationReceipt({this.id});


  @override
  _DeleteConfirmationReceiptState createState() => _DeleteConfirmationReceiptState( id : this.id);
}

class _DeleteConfirmationReceiptState extends State<DeleteConfirmationReceipt> {

  String id;
  ReceiptService receiptService = ReceiptService();
  String errorMessage = '';

  _DeleteConfirmationReceiptState({this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 50,),
        Text(
          'Deja remover a receita ?',
          style: TextStyle(
            color: Colors.red[700],
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ) ,
        SizedBox(height: 50,),


        FlatButton.icon(
            color: Colors.red[300],
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
                Icons.cancel
            ),
            label: Text('Não')),

        SizedBox(height: 30,),

        FlatButton.icon(
            color: Colors.green[300],
            onPressed: () async {
              bool success = await receiptService.deleteReceipt(this.id);
              if(success){
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }
              else{
                errorMessage = 'Um error ocorreu ao remover a receita. Por favor, tente mais tarde.';
              }
            },
            icon: Icon(
                Icons.check_circle_outline
            ),
            label: Text('Sim')) ,

         SizedBox(height: 30,),
        Text('$errorMessage'),




      ],
    );
  }
}
