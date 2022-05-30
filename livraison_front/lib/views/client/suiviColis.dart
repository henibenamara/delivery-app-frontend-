import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class suiviColis extends StatefulWidget {

  @override
  _suiviColisState createState() => _suiviColisState();
}
class _suiviColisState extends State<suiviColis> {
  TextEditingController num = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(

            children: [

              TextFormField(
                controller: num,
                cursorColor: Theme.of(context).cursorColor,
                initialValue: 'entrer num de livraison',
                maxLength: 20,
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: 'suivi colis',
                  labelStyle: TextStyle(
                    color: Color(0xFF6200EE),
                  ),

                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }


}

