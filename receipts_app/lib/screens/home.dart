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
  List<RecipeModel> recipes;
  // Armazena o widget de acordo com recipe
  Widget listWidget;

  List<Widget> listOfWidget = new List<Widget>();


  // Buscar as receitas
  // o resultado da busca atribui à variável recipe.
  // será utilizado para validar qual Widget vai utilizar
  void getAllRecipes() async{

    RecipeService recipe = RecipeService();

    List<RecipeModel> response = await recipe.getAll();

    setState(() {
      recipes = response;
    });

    if(recipes != null) {
      recipes.forEach((element) {
        setState(() {
          listOfWidget.add(RecipeBoxedCard(recipe: element));
        });
      });
    }


  }

  @override
  void initState() {
    super.initState();
    // Executa a busca de receipts quando inicia o State.
    getAllRecipes();
  }

  @override
  Widget build(BuildContext context) {

    // Verificar qual Widget utilizar
    //
    // Recipes != null  Então  ListView com itens encontrados.
    // Receipes == null  Então  Text informando que não foram encontradas recipes.
    //
    // Depenendo da condição, atribui à variavel listWidget o Widget selecionado.
    if(recipes != null)
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
