import 'package:flutter/material.dart';
import 'package:receiptsapp/models/receipt-model.dart';
import 'package:url_launcher/url_launcher.dart';

class ReceiptBoxedCard extends StatelessWidget{

  final ReceiptModel receipt;
  
  ReceiptBoxedCard({this.receipt});
  
  String _get(){

    String description= '';

    if(receipt.description != ''  || receipt.description.isNotEmpty){

      int descriptionLength = receipt.description.length;

      if(descriptionLength > 25){
        description = receipt.description.substring(0,25) + '...';
      }
      else{
        description = receipt.description;
      }
    }

    return description;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Color> _colors = [Colors.purple[200], Colors.purple[500]];

    return Container(
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          colors: _colors,
          begin: Alignment.bottomCenter,
          end: Alignment(0.0, 0.0),
          stops: [0,0.6]
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child:  Text(
                      '${receipt.getNameSized(15)}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color:  Colors.white
                      ),
                    )

              ),
            ),

           Row(

              mainAxisAlignment:  MainAxisAlignment.end,
              children: <Widget>[

                FlatButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(
                        context,
                        '/detail-receipt',
                        arguments: receipt
                    );
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    size : 20,
                  ),
                  label: Text(''),
                ),

                FlatButton.icon(
                  onPressed: (){
                    print('link');
                    _launchURL(receipt.link);
                  },
                    icon: Icon(
                      Icons.link,
                      size : 20,
                    ),
                  label: Text(''),
                ),

                ],
              ),

            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${receipt.getDescriptionSized(20)}',
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        wordSpacing: 2.0
                    ),
                  )
              ),
            ),


          ],
        ),
      ),
    );
  }

}
