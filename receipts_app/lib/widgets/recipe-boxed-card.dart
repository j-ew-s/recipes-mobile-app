import 'package:flutter/material.dart';
import 'package:receiptsapp/models/recipe-model.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeBoxedCard extends StatelessWidget{

  final RecipeModel recipe;
  
  RecipeBoxedCard({this.recipe});


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
                      '${recipe.getNameSized(15)}',
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
                        '/detail-recipe',
                        arguments: recipe
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
                    _launchURL(recipe.link);
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
                    '${recipe.getDescriptionSized(20)}',
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
