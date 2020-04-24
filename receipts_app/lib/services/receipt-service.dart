import 'package:http/http.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'dart:convert' as convert;

class ReceiptService{

  ReceiptService();

  var url = 'http://10.0.2.2:8087/recipes/';

  // Busca todas as receipts
  //
  // Api utiliza:
  //  Verbo :  Get
  //  URL :    /receipts
  //  Params : não existe parametros
  //
  // Retorna uma lista de ReceiptModel
  Future<List<ReceiptModel>> getAll() async {

    try{

        List<ReceiptModel> list = new List<ReceiptModel>();

        Response response = await get(this.url);

        print(response.statusCode);
        print(response.body);

        if(response.statusCode == 200){

          var body = convert.jsonDecode(response.body);

          var bodyReceipts = body['receipts'];

          if(bodyReceipts != null) {

            list = (bodyReceipts as List).map((i) =>
                ReceiptModel.fromJson(i)
            ).toList();

          }

          return list;
        }

        return list;

     }
     catch(e){
       print(e.toString());
       return null;
     }
  }

  // Busca uma Receipt especifica por ID
  //
  // Api utiliza:
  //  Verbo :  Get
  //  URL :    /receipts/<id>
  //  Params : ID do tipo string
  //
  // Retorna uma ReceiptModel
  Future<ReceiptModel> getById(String id) async {

    //var url = 'http://10.0.2.2:8061/receipts/$id';

    try{

      ReceiptModel receipt ;

      Response response = await get(this.url+id);

      if(response.statusCode == 200){

        var body = convert.jsonDecode(response.body);

        var bodyReceipts = body['recipe'];

        receipt = bodyReceipts.map((i) =>
            ReceiptModel.fromJson(i)
        );

        return receipt;
      }

      return null;

    }
    catch(e){
      print(e.toString());
      return null;
    }

  }


  // Cria ou Atualiza uma Receita
  //
  // Se o ReceiptModel recebido como parametro
  //    Possuir id entao chama _update
  //    Não possuir id então chama _create
  //
  // Retorna um bool indicando
  //    true  : ação executada com sucesso
  //    false : ação obteve erro
  Future<bool> createOrUpdate(ReceiptModel receipt) async {

    if(receipt.id == null){

      return await  _create(receipt);

    }
    else{

      return await _update(receipt);

    }

  }

  // Remove uma receipt por seu ID
  //
  // Api utiliza:
  //  Verbo :  DELETE
  //  URL :    /receipts/<id>
  //  Params : ID do tipo string
  //
  // Retorna um bool indicando
  //    true  : ação executada com sucesso
  //    false : ação obteve erro
  Future<bool> deleteReceipt(String id) async {

    if(id.isEmpty){
      return false;
    }
    else{
      try{

        //var url = 'http://10.0.2.2:8061/receipts/$id';

        Response response = await delete(
          this.url+id,
          headers:  { 'Content-type': 'application/json',
            'Accept': 'application/json'},
        );

        if(response.statusCode == 200){
          return true;
        }
        else{
          print(response.body);
          print(response.statusCode);
          print(response.runtimeType);

          return false;
        }

      }
      catch(e ){
        print(e.toString());
        return false;
      }
    }

  }

  // Cria uma nova receita
  //
  // Api utiliza:
  //  Verbo :  POST
  //  URL :    /receipts/<id>
  //  Params : ID do tipo string
  //  Body : receitps ( formato json)
  //  HTTP Status de sucesso : 201
  //
  // Retorna um bool indicando
  //    true  : ação executada com sucesso
  //    false : ação obteve erro
  Future<bool> _create(ReceiptModel receipt) async {

    //var url = 'http://10.0.2.2:8061/receipts/';
    Map<String, String> headers = {"Content-type": "application/json"};

    try{

      Response response = await post(
        this.url,
        body: receipt.toJsonInsert(),
        headers:  headers,
      );

      if(response.statusCode == 200){

        print('newwwwwwwwwwww');

        return true;
      }
      else{
        print(response.body);
        print(response.statusCode);
        print(response.runtimeType);

        return false;
      }
    }
    catch(e){
      print(e.toString());
      return false;
    }

  }


  // Atualiza uma receita
  //
  // Api utiliza:
  //  Verbo :  PUT
  //  URL :    /receipts/<id>
  //  Params : ID do tipo string
  //  Body : receitps ( formato json)
  //  HTTP Status sucesso : 200
  //
  // Retorna um bool indicando
  //    true  : ação executada com sucesso
  //    false : ação obteve erro
  Future<bool> _update(ReceiptModel receipt) async {

    print(receipt);
    print(receipt.toJson());

    //var url = 'http://10.0.2.2:8061/receipts/${receipt.id}';
    Map<String, String> headers = {"Content-type": "application/json"};

    try{

      Response response = await put(
        this.url+receipt.id,
        body: receipt.toJson(),
        headers: headers,
      );

      if(response.statusCode == 200){
        return true;
      }
      else{

        print(response.body);
        print(response.statusCode);
        print(response.runtimeType);

        return false;
      }

    }
    catch(e){
      print(e.toString());
      return false;
    }


  }
}