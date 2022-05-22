import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/constant/app_constants.dart';

import '../../services/livraisonService.dart';


class Dashboard_Client extends StatefulWidget {
  Dashboard_Client(this.id,this.image,this.nom,this.email);
  final String?  image;
  final String?  id;
  final String?  nom;
  final String?  email;


  @override
  _Dashboard_Client createState() => _Dashboard_Client();
}

class _Dashboard_Client extends State<Dashboard_Client> with SingleTickerProviderStateMixin  {

  late TabController controller;

  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: LivraisonService().getStatsClient(widget.id.toString()),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          print('snapshot is : ${snapshot.data}');

          if ((snapshot.hasData)) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 600,
                  child: ListView(children: <Widget>[
                    Column(children: <Widget>[
                      Stack(children: <Widget>[
                        Container(
                          height: 250.0,
                          width: double.infinity,
                          color: Color(getColorHexFromStr('#FDD148')),
                        ),
                        Positioned(
                          bottom: 250.0,
                          right: 100.0,
                          child: Container(
                            height: 400.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200.0),
                                color:
                                Color(getColorHexFromStr('#FEE16D')).withOpacity(0.4)),
                          ),
                        ),
                        Positioned(
                          bottom: 300.0,
                          left: 150.0,
                          child: Container(
                              height: 300.0,
                              width: 300.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150.0),
                                  color: Color(getColorHexFromStr('#FEE16D'))
                                      .withOpacity(0.5))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 15.0),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 15.0),
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 75.0,
                                  width: 75.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(37.5),
                                      border: Border.all(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          width: 3.0),
                                      image: DecorationImage(
                                          image: NetworkImage(AppConstants.API_URL+"/"+widget.image.toString()),fit: BoxFit.cover
                                      )),
                                ),
                                SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.nom.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.email.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontSize: 14.0,
                                          color: Colors.black.withOpacity(0.7)),
                                    )
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width - 300.0),

                                SizedBox(height: 15.0)
                              ],
                            ),
                            SizedBox(height: 10.0),

                            SizedBox(height: 25.0),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    cardDetails('Total depense', 'assets/images/card.png', snapshot.data!['sumLivrée'].toString()+" DT"),
                                    cardDetails(
                                        'livraison en attend', 'assets/images/returnbox.png', snapshot.data!['livraisonNonLivrée'].toString()),

                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    cardDetails('livraison Livrée', 'assets/images/trucks.png', snapshot.data!['livraisonLivrée'].toString()),
                                    cardDetails('livraison En cours', 'assets/images/box.png', snapshot.data!['livraisonEncours'].toString()),
                                  ],
                                ),
                                SizedBox(height: 5.0)
                              ],
                            )
                          ],
                        )
                      ]),
                      SizedBox(height: 15.0),
                      listItem('Consulter Historique', Colors.red, Icons.account_box),

                      listItem('Customer service', Color(getColorHexFromStr('#ECB800')),
                          Icons.person)
                    ])
                  ]),
                );
              },
              itemCount: 1,
            );
          } else {
            return Center(
              child: Text('data is null'),
            );
          }
        },
      ),







    );
  }

  Widget listItem(String title, Color buttonColor, iconButton) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: buttonColor.withOpacity(0.3)),
            child: Icon(iconButton, color: buttonColor, size: 25.0),
          ),
          SizedBox(width: 25.0),
          Container(
            width: MediaQuery.of(context).size.width - 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.0)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardDetails(String title, String imgPath, String valueCount) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        height: 125.0,
        width: (MediaQuery.of(context).size.width / 2) - 20.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Image.asset(
                imgPath,
                fit: BoxFit.cover,
                height: 50.0,
                width: 50.0,
              ),
            ),
            SizedBox(height: 2.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(title,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 15.0,
                    color: Colors.black,
                  )),
            ),
            SizedBox(height: 3.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(valueCount,
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 15.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
