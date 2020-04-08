import 'package:http/http.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'dart:convert' as convert;

class ReceiptService{

  String id;
  String name;
  String description;
  String link;
  int rate;
  List<String> tags;

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
        else {
          print(response.body);

          List<String> tags = new List<String>();
          tags.add('a');
          tags.add('b');

          ReceiptModel new1 = ReceiptModel();
          new1.id = '12';
          new1.name = 'Nome 1';
          new1.description = 'desc 1';
          new1.link = 'http://google.com';
          new1.rate = 3;
          new1.tags = tags;

          list.add(new1);
        }

        return list;

     }
     catch(e){
       print(e.toString());
       return null;
     }
  }

  // Busca todas as receipts
  //
  // Api utiliza:
  //  Verbo :  Get
  //  URL :    /receipts
  //  Params : não existe parametros
  //
  // Retorna uma lista de ReceiptModel
  void getById(String id) async {

    Response response = await get('');

  }

}