import 'package:flutter/material.dart';
import 'package:receiptsapp/models/receipt-model.dart';

class CreateReceipt extends StatefulWidget {
  @override
  _CreateReceiptState createState() => _CreateReceiptState();
}

class _CreateReceiptState extends State<CreateReceipt> {

  ReceiptModel receipt;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[

              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Name is obligatry';
                  }
                  receipt.name = value;
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description'
                ),
                onChanged: (value) => {
                  receipt.name = value
                },
              ),

              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Link'
                ),
                onChanged: (value) => {
                  receipt.link = value
                },
              ),


              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'rate'
                ),
                onChanged: (value) => {
                  receipt.rate = int.parse(value)
                },
              ),


            ]
        )
    );
  }
}
