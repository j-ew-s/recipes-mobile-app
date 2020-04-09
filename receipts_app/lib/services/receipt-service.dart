import 'package:http/http.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'dart:convert' as convert;

class ReceiptService{

  ReceiptService();


  // Busca todas as receipts
  //
  // Api utiliza:
  //  Verbo :  Get
  //  URL :    /receipts
  //  Params : não existe parametros
  //
  // Retorna uma lista de ReceiptModel
  Future<List<ReceiptModel>> getAll() async {

    var url = 'http://10.0.2.2:8061/receipts';

    try{

        List<ReceiptModel> list = new List<ReceiptModel>();

        Response response = await get(url);

        if(response.statusCode == 200){

          var body = convert.jsonDecode(response.body);

          var bodyReceipts = body['receipts'];

          list = (bodyReceipts as List).map((i) =>
              ReceiptModel.fromJson(i)
          ).toList();

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

    var url = 'http://10.0.2.2:8061/receipts/$id';

    print(url);

    try{

      ReceiptModel receipt ;

      Response response = await get(url);

      if(response.statusCode == 200){

        var body = convert.jsonDecode(response.body);
        print(body);
        var bodyReceipts = body['receipt'];

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

    if(receipt.id.isEmpty){

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

        var url = 'http://10.0.2.2:8061/receipts/$id';

        ReceiptModel receipt ;

        Response response = await delete(
          url,
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

           var url = 'http://10.0.2.2:8061/receipts/';

        print(url);

        try{

          ReceiptModel receipt ;

          Response response = await post(
            url,
            body: receipt,
            headers:  { 'Content-type': 'application/json',
              'Accept': 'application/json'},
          );

          if(response.statusCode == 201){

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

    print(receipt.id);
    
    var url = 'http://10.0.2.2:8061/receipts/${receipt.id}';
    Map<String, String> headers = {"Content-type": "application/json"};
    print(url);

    try{

      Response response = await put(
        url,
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