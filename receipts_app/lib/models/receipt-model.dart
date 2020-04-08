class ReceiptModel{

  String id;
  String name;
  String description;
  String link;
  int rate;
  List<String> tags;

  ReceiptModel({this.id, this.name, this.description, this.link, this.rate, this.tags});

  factory ReceiptModel.fromJson(dynamic json) {

    return ReceiptModel(
        id: json['ID'] as String,
        name: json['Name'] as String ,
        description: json['Description'] as String,
        link: json['Link'] as String,
        rate: json['Rate'] as int,
        tags: new List<String>.from(json['Tags'])
    );
  }

}
