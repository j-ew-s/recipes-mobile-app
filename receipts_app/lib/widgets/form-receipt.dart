import 'package:flutter/material.dart';
import 'package:receiptsapp/models/recipe-model.dart';
import 'package:receiptsapp/services/recipe-service.dart';
import 'package:receiptsapp/style/text-decoration.dart';


class FormReceipt extends StatefulWidget {

  final RecipeModel receipt;
  FormReceipt({this.receipt});
  @override
  _FormReceiptState createState() => _FormReceiptState(receipt: receipt);
}

class _FormReceiptState extends State<FormReceipt> {

  RecipeModel receipt;
  _FormReceiptState({this.receipt});


  final _formKey = GlobalKey<FormState>();
  String _id ;
  String _name ;
  String _description ;
  String _link ;
  int _rate = 0;
  bool firstLoad = true;
  List<String> _tags = List<String>();
  Widget message;
  Widget cancelButton;
  String buttonsText = 'Atualizar';

  RecipeService receiptService = RecipeService();

  @override
  Widget build(BuildContext context) {

    print(receipt.toJson());

    if(receipt.id != null){
      message = Text('ID da Receita :  ${receipt.id}');
      if(firstLoad) {
        _rate = _rate == 0 ? receipt.rate : 1;
        firstLoad = false;
      }
    }else{
      message = Text('Criando uma nova receita');
      setState(() {
        buttonsText = 'Adicionar';
      });
    }

    if(receipt.id != null){
      cancelButton =  RaisedButton(
        color: Colors.red,
        child: Text(
          'Cancelar',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async{
          print('cancel');
          if(_formKey.currentState.validate()){
            Navigator.pop(context);
          }
        },
      );
    }
    else{

      cancelButton = Container(
        child: Text(''),
      );
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
                          initialValue: receipt.name ?? '',
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
                    Row(
                        children: <Widget>[

                          Expanded(
                            child:  FlatButton.icon(
                                onPressed: (){
                                  setState(() {
                                    _rate = 1;
                                  });
                                },
                                icon: new Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: _rate == 1 ? Colors.red[300] : Colors.grey[300],
                                ),
                                label: Text('')),
                          ),

                          Expanded(
                            child: FlatButton.icon(
                                onPressed: (){
                                  setState(() {
                                    _rate = 2;
                                  });
                                },
                                icon: new Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: _rate == 2 ? Colors.red[200] : Colors.grey[300],
                                ),
                                label: Text('')),
                          ),

                          Expanded(
                            child: FlatButton.icon(
                                onPressed: (){
                                  setState(() {
                                    _rate = 3;
                                  });
                                },
                                icon: new Icon(
                                  Icons.sentiment_neutral,
                                  color: _rate == 3 ? Colors.blue[300] : Colors.grey[300],
                                ),
                                label: Text('')),
                          ),

                          Expanded(
                            child:FlatButton.icon(
                                onPressed: (){
                                  setState(() {
                                    _rate = 4;
                                  });
                                },
                                icon: new Icon(
                                  Icons.sentiment_satisfied,
                                  color: _rate == 4 ? Colors.green[300] : Colors.grey[300],
                                ),
                                label: Text('')),
                          ),

                          Expanded(
                            child: FlatButton.icon(
                                onPressed: (){
                                  setState(() {
                                    _rate = 5;
                                  });
                                },
                                icon: new Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: _rate == 5 ? Colors.green[500] : Colors.grey[300],
                                ),
                                label: Text('')),
                          ),

                        ],
                    ),



                        // Botao
                        SizedBox(height: 30.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[

                              cancelButton,

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
                                  receipt.tags = _tags ?? receipt.tags;

                                  bool result = await receiptService.createOrUpdate(receipt);

                                  if(result) {

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
