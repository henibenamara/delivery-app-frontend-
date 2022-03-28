import 'package:flutter/material.dart';
import 'package:front_livraison/models/livraison.dart';
import 'package:front_livraison/services/livraisonService.dart';

import '../../widgets/drawer.dart';
import 'EditLivraisont.dart';

class DetailLivraison extends StatefulWidget {
  DetailLivraison(this.livraison);

  final Livraison livraison;

  @override
  _DetailLivraisonState createState() => _DetailLivraisonState();
}

class _DetailLivraisonState extends State<DetailLivraison> {
  _DetailLivraisonState();

  final LivraisonService api = LivraisonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: createDrawer(context),
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('numLivraison:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livraison.numLivraison.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('adresseExp:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livraison.adresseExp.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('adressseDes:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livraison.adressseDes.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('dateDeLivraison:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livraison.dateDeLivraison.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Type colis',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livraison.typeColis.toString(),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.livraison.DesColis != null,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('DesColis',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8))),
                              Text(
                                widget.livraison.DesColis.toString(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('poidsColis',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livraison.poidsColis.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              splashColor: Colors.red,
                              onPressed: () {
                                _navigateToEditScreen(
                                    context, widget.livraison);
                              },
                              child: Text('Edit',
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.blue,
                            ),
                            RaisedButton(
                              splashColor: Colors.red,
                              onPressed: () {
                                _confirmDialog();
                              },
                              child: Text('Delete',
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                //  api.deleteLivraison(widget.livraison.sId.toString());
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _navigateToEditScreen(BuildContext context, Livraison livraison) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataWidget()),
    );
  }
}
