import 'package:flutter/material.dart';
import 'package:receiptsapp/models/recipe-model.dart';
import 'package:receiptsapp/services/recipe-service.dart';
import 'package:receiptsapp/widgets/loading.dart';
import 'package:receiptsapp/widgets/recipe-boxed-card.dart';

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

    RecipeService receipt = RecipeService();

    List<RecipeModel> response = await receipt.getAll();

    setState(() {
      print("TEmos");
      print(response);
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
    // Recipes != null  Então  ListView com itens encontrados.
    // Receipes == null  Então  Text informando que não foram encontradas receipts.
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
                  Navigator.pushNamedAndRemoveUntil(context, '/create-recipe', (route) => false);
                },
              ),
            );
  }
}
