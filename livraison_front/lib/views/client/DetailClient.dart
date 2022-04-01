import 'package:flutter/material.dart';
import 'package:livraison_front/views/client/EditClient.dart';


import '../../models/client.dart';

import '../../services/clientService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';


class DetailClient extends StatefulWidget {
  DetailClient(this.client);

  final Client client;

  @override
  _DetailClientState createState() => _DetailClientState();
}

class _DetailClientState extends State<DetailClient> {
  _DetailClientState();

  final ClientService api = ClientService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ResponsableDrawer(context),
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
                            Text('nom:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.client.nom.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('prenom:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.client.prenom.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('clientTel:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.client.clientTel.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('clientAdresse:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.client.clientAdresse.toString(),
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
                                    context, widget.client);
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

  _navigateToEditScreen(BuildContext context, Client client) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataWidget()),
    );
  }
}
