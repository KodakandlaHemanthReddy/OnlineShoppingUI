import 'package:flutter/material.dart';
import 'package:flutter_shoppingui/datagetting.dart';
import 'package:flutter_shoppingui/main.dart';


class ShoesView extends StatefulWidget {
  @override
  _ShoesViewState createState() => _ShoesViewState();
}

class _ShoesViewState extends State<ShoesView> {

  var shoesData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Data().getShoesData(context).then((onValue){
      if(mounted){
        setState(() {
          shoesData = onValue;
        });
      }
    });
  }
  Color cardColor= Colors.white;
  Color textColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.count(
        primary: true,
        crossAxisCount: 2,
        childAspectRatio: 0.80,
        children: List.generate(shoesData.length, (index){
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10.0),
            child: Material(
              child: InkWell(
                onTap: (){
                  Data().saveDataToFavoritesDataBase(shoesData[index]);
                  ShoppingUI.myTabbedPageKey.currentState.tabController.animateTo(2);
                },
                child: new Card(
                    color: cardColor,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(5.0))),
                    elevation: 1.5,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Hero(
                          tag:shoesData[index].title,
                          child: new Image.network(
                            shoesData[index].image,
                            height: 150.0,
                            width: 100.0,),
                        ),
                        new Padding(
                          padding: EdgeInsets.only(left: 10.0,top: 10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Text(shoesData[index].title,style: TextStyle(color: textColor,fontWeight: FontWeight.w700,fontSize: 18.0),),
                              new Text(shoesData[index].price,style: TextStyle(color: textColor,fontWeight: FontWeight.w500,fontSize: 15.0)),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          );
        }),
      ),
    );
  }
}
