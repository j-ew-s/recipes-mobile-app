import 'package:flutter/material.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'package:receiptsapp/services/receipt-service.dart';
import 'package:receiptsapp/style/text-decoration.dart';

class FormReceipt extends StatefulWidget {

  ReceiptModel receipt;
  FormReceipt({this.receipt});
  @override
  _FormReceiptState createState() => _FormReceiptState(receipt: receipt);
}

class _FormReceiptState extends State<FormReceipt> {

  ReceiptModel receipt;
  _FormReceiptState({this.receipt});

  final _formKey = GlobalKey<FormState>();
  String _id;
  String _name;
  String _description;
  String _link;
  int _rate;
  List<String> tags;
  Widget message;
  String buttonsText = 'Atualizar';

  ReceiptService receiptService = ReceiptService();

  @override
  Widget build(BuildContext context) {


    if(receipt.id.isNotEmpty){
      message = Text('ID da Receita :  ${receipt.id}');
    }else{
      message = Text('Criando uma nova receita');
      setState(() {
        buttonsText = 'Adicionar';
      });

    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child :
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10,),
                        message,

                        // NOME
                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nome da Receita*',
                            style:  TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              wordSpacing: 2
                            ),
                          )
                        ),
                        TextFormField(
                          decoration: textInputDecoration,
                          initialValue: receipt.name,
                          validator : (val) => val.isEmpty ? 'Nome da receita é obrigatório!' : null,
                          onChanged : (val) => setState(() => _name = val),
                        ),

                        // Descrição
                        SizedBox(height: 20,),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Descricao',
                              style:  TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  wordSpacing: 2
                              ),
                            )
                        ),
                        TextFormField(
                          decoration: textInputDecoration,
                          initialValue: receipt.description,
                          onChanged : (val) => setState(() => _description = val),
                          maxLines: 8,
                        ),

                        // Link
                        SizedBox(height: 20,),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Link*',
                              style:  TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  wordSpacing: 2
                              ),
                            )
                        ),
                        TextFormField(
                          decoration: textInputDecoration,
                          initialValue: receipt.link,
                          onChanged : (val) => setState(() => _link = val),
                          validator : (val) => val.isEmpty ? 'Link da receita é obrigatório!' : null,
                        ),

                        // Classificação
                        SizedBox(height: 20,),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Classificação',
                              style:  TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  wordSpacing: 2
                              ),
                            )
                        ),
                        Slider(
                          min: 1.0,
                          max: 5.0,
                          divisions: 5,
                          onChanged: (val) {
                            setState(() {
                              _rate = val.round();
                            });
                          },
                          value: (_rate ?? receipt.rate).toDouble(),
                        ),

                        // Botao
                        SizedBox(height: 30.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[

                              RaisedButton(
                                color: Colors.red,
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async{
                                  if(_formKey.currentState.validate()){
                                      Navigator.pop(context);
                                  }
                                },
                              ),

                              SizedBox(width: 30,),

                              RaisedButton(
                              color: Colors.green,
                              child: Text(
                                buttonsText,
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async{
                                if(_formKey.currentState.validate()){

                                  receipt.id = _id ?? receipt.id;
                                  receipt.name = _name ?? receipt.name;
                                  receipt.description = _description ?? receipt.description;
                                  receipt.link = _link ?? receipt.link;
                                  receipt.rate = _rate ?? receipt.rate;
                                  receipt.tags = receipt.tags;

                                  bool result = await receiptService.createOrUpdate(receipt);

                                  if(result) {
                                    print('PUSH REPLACEMENTE');
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/', (r) => false);
                                  }
                                  else{
                                    print('parece que nao');
                                  }

                                }
                              },
                            ),

                          ]
                        ),
                        SizedBox(height: 25.0),
                    ],
                  ),
                ),
              )
            ),
          );
        },
    );
  }

}
