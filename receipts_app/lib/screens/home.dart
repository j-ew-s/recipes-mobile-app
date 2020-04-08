import 'package:flutter/material.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'package:receiptsapp/services/receipt-service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Lista de Receitas
  List<ReceiptModel> receipts;
  // Armazena o widget de acordo com receipts
  Widget listWidget;


  // Buscar as receitas
  // o resultado da busca atribui à variável receipts.
  // será utilizado para validar qual Widget vai utilizar
  void getAllReceipts() async{

    ReceiptService receipt = ReceiptService();

    List<ReceiptModel> response = await receipt.getAll();


    setState(() {
      receipts = response;
    });

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
      listWidget = ListView.builder(
        itemCount: receipts.length,
        itemBuilder: (context, index)
        {
          return Padding(
            padding:  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){},
                title: Text(receipts[index].name),
              ),
            ),
          );
        },
      );
    }
    else{
      listWidget = Text(' Não há receitas cadastradas.');
    }



    // Cria o Widget da página
    // Utiliza a variável listWidget que foi atribuida à cima.
    return Scaffold(
              appBar: AppBar(

              ),
              body: listWidget,
              floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add
                ),
                onPressed: (){

                },
              ),
            );
  }
}
