import 'package:flutter/material.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'package:receiptsapp/services/receipt-service.dart';
import 'package:receiptsapp/widgets/form-receipt.dart';
import 'package:receiptsapp/widgets/loading.dart';

class EditReceipt extends StatefulWidget {
  @override
  _EditReceiptState createState() => _EditReceiptState();
}

class _EditReceiptState extends State<EditReceipt> {

  ReceiptModel receipt;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
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
