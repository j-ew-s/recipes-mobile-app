import 'package:flutter/material.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'package:receiptsapp/services/receipt-service.dart';
import 'package:receiptsapp/widgets/loading.dart';
import 'package:receiptsapp/widgets/receipt-boxed-card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Lista de Receitas
  List<RecipeModel> receipts;
  // Armazena o widget de acordo com receipts
  Widget listWidget;

  List<Widget> listOfWidget = new List<Widget>();


  // Buscar as receitas
  // o resultado da busca atribui à variável receipts.
  // será utilizado para validar qual Widget vai utilizar
  void getAllReceipts() async{

    ReceiptService receipt = ReceiptService();

    List<RecipeModel> response = await receipt.getAll();

    setState(() {
      receipts = response;
    });

    if(receipts != null) {
      receipts.forEach((element) {
        setState(() {
          listOfWidget.add(ReceiptBoxedCard(receipt: element));
        });
      });
    }


  }

  @override
  void initState() {
    super.initState();
    // Executa a busca de receipts quando inicia o State.
    getAllReceipts();
  }

  @override
  Widget build(BuildContext context) {

    // Verificar qual Widget utilizar
    //
    // Receipts != null  Então  ListView com itens encontrados.
    // Receitps == null  Então  Text informando que não foram encontradas receipts.
    //
    // Depenendo da condição, atribui à variavel listWidget o Widget selecionado.
    if(receipts != null)
    {
      listWidget = GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: listOfWidget,
      );
    }
    else{
      listWidget = Loading();
    }

    // Cria o Widget da página
    // Utiliza a variável listWidget que foi atribuida à cima.
    return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple[700],
                title: Text('Suas receitas :) '),
                centerTitle: true,
              ),
              body: Container(
                child: listWidget,
                color: Colors.purple[800],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add
                ),
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/create-receipt', (route) => false);
                },
              ),
            );
  }
}
