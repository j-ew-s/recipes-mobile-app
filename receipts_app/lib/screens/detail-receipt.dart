import 'package:flutter/material.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'package:receiptsapp/widgets/loading.dart';

class DetailReceipt extends StatefulWidget {

  @override
  _DetailReceiptState createState() => _DetailReceiptState();
}

class _DetailReceiptState extends State<DetailReceipt> {

  ReceiptModel receipt;

  @override
  Widget build(BuildContext context) {


   var passedArgument = ModalRoute.of(context).settings.arguments;

   if(passedArgument != null){
     receipt = passedArgument;
   }
   else{
     List<String> aa = new List<String>();
     receipt = ReceiptModel(tags: aa , rate: 0, link: '', description: '', name: '', id: '');
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
                Navigator.pushNamed(context, '/edit-receipt', arguments:  receipt
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
                Navigator.pushNamed(context, '/edit-receipt', arguments:  receipt
                );
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
