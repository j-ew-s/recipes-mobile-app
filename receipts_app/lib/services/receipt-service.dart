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

}