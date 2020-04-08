import 'dart:convert';

class ReceiptModel{

  String id;
  String name;
  String description;
  String link;
  int rate;
  List<String> tags;

  ReceiptModel({this.id, this.name, this.description, this.link, this.rate, this.tags});


  // Gets Description property value sized by a parameter.
  // Returns a Description substring accordingly to size parameter.
  String getDescriptionSized(int size){

    return _getStringSized(size, this.description);
  }

  // Gets Name property value sized by a parameter.
  // Returns a Name substring accordingly to size parameter.
  String getNameSized(int size){

    return _getStringSized(size, this.name);
  }

  // Gets Name property value sized by a parameter.
  // Returns a Name substring accordingly to size parameter.
  String getLinkSized(int size){

    return _getStringSized(size, this.link);
  }

  // Resize a text accordingly to Size and Value parameters
  // Returns a String  substring accordingly to Size parameter.
  String _getStringSized(int size, String value){

    String result = '';

    if(value!= ''  || value.isNotEmpty){

      int valueLength = value.length;

      if(valueLength > size){
        result = value.substring(0,size) + '...';
      }
      else{
        result = value;
      }
    }

    return result;
  }


  factory ReceiptModel.fromJson(dynamic json) {

    return ReceiptModel(
        id:  json['ID'] as String,
        name: json['Name'] as String ,
        description: json['Description'] as String,
        link: json['Link'] as String,
        rate: json['Rate'] as int,
        tags: new List<String>.from(json['Tags'])
    );
  }

  String toJson() {
      return json.encode({
        'id': this.id,
        'name': this.name,
        'description': this.description,
        'link': this.link,
        'rate': this.rate,
        'tags': this.tags,
      });

  }


}
