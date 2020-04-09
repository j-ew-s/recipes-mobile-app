import 'package:flutter/material.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'package:receiptsapp/widgets/form-receipt.dart';

class CreateReceipt extends StatefulWidget {
  @override
  _CreateReceiptState createState() => _CreateReceiptState();
}

class _CreateReceiptState extends State<CreateReceipt> {

  ReceiptModel receipt = ReceiptModel();

  final _formKey = GlobalKey<FormState>();

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
      body: FormReceipt(receipt: receipt),
    );
  }
}
