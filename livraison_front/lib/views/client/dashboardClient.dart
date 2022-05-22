import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/views/livraison/DetailLivraiosnAdmin.dart';
import 'package:livraison_front/views/livraison/DetailLivraisonClient.dart';

import '../../constant/app_constants.dart';
import '../../models/livraison.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer_client.dart';
import '../livraison/LivraisonListByClient.dart';

class DashboardClient extends StatefulWidget {

  @override
  _DashboardClientState createState() => _DashboardClientState();
}
class _DashboardClientState extends State<DashboardClient> {
  TextEditingController num = TextEditingController();
  String? numliv="1";
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent),
        drawer: clientDrawer(context),
        body: SafeArea(
          child: Column(
            children: [
              Text("bienvenue sur notre platform",style: TextStyle(fontSize: 25),),
              SizedBox(
                height: 250,
                width: width,
                child: Image.network(
                    'https://media4.giphy.com/media/RG8GoChHjouVgJbCL3/giphy.gif?cid=ecf05e478ado88raxbhuz4ex8aptsy0waawfxvkueeoxiflz&rid=giphy.gif&ct=g'),
              ),
              Card(

                shadowColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),side: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),),
                child: Row(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage("assets/images/box.png"),radius: 50,backgroundColor: Colors.white,),
                    SizedBox(width: 10,),
                    Text("Envoyer un Colis",style: TextStyle(fontSize: 28),),

                  ],
                ),

              ),
              SizedBox(height: 20,),
              Card(
                shadowColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),side: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),),
                child: Row(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage("assets/images/box.png"),radius: 50,backgroundColor: Colors.white,),
                    SizedBox(width: 10,),
                    Text("Suivi votre Colis",style: TextStyle(fontSize: 28),),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              Card(

                shadowColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),side: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LivraisonClient()));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(backgroundImage: AssetImage("assets/images/box.png"),radius: 50,backgroundColor: Colors.white,),
                      SizedBox(width: 10,),
                      Text("Votre Historique",style: TextStyle(fontSize: 28),),

                    ],
                  ),
                ),
              ),

            ],
          )
        )
    );
  }


}
/**
Column(

children: [
Row(children: [
Container(
width: 290,
child: TextFormField(
keyboardType: TextInputType.number,
controller: num,
cursorColor: Theme.of(context).cursorColor,

maxLength: 4,
decoration: InputDecoration(

hintText: "entrer le numero de livraison",
labelText: 'suivi colis',
labelStyle: TextStyle(
color: Color(0xFF6200EE),
),


enabledBorder: UnderlineInputBorder(
borderSide: BorderSide(color: Color(0xFF6200EE)),
),
),
),
),
Container(
width: 120,
child: ElevatedButton(
onPressed: () {

setState(() {
numliv=num.text.toString();
});

},
child: Text('rechercher'),
),
)
]),
Container(
height: 200,

child: FutureBuilder(
future: LivraisonService().getListLivraisonByNum(numliv.toString()),
builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
print('snapshot is : ${snapshot.data}');

if ((snapshot.hasData)) {
return ListView.builder(
itemBuilder: (context, index) {
return ListTile(
leading: new Image.network(
AppConstants.API_URL+"/"+snapshot.data![index]['imageUrl'],
fit: BoxFit.cover,
width: 100.0,
),

title: new Text(
"De  " +
snapshot.data![index]['AdresseExp'] +
" vers  " +
snapshot.data![index]['AdressseDes'],
style: new TextStyle(
fontSize: 14.0, fontWeight: FontWeight.bold),
),
subtitle: new Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
new Text(
"Num:" +
snapshot.data![index]['numLivraison']
    .toString(),
style: new TextStyle(
fontSize: 14.0, fontWeight: FontWeight.normal)),
new Text(
'Description: ${snapshot.data![index]['colisId']['DesColis']}',
style: new TextStyle(
fontSize: 14.0, fontWeight: FontWeight.normal)),
]),
//    title: Text(snapshot.data![index]['numLivraison'].toString()),
//    subtitle: Text(snapshot.data![index]['AdressseDes']),
onTap: () {
Livraison livraison = new Livraison(
adresseExp: snapshot.data![index]['AdresseExp'],
adressseDes: snapshot.data![index]['AdressseDes'],
dateDeLivraison: snapshot.data![index]
['DateDeLivraison'],
DesColis: snapshot.data![index]['colisId']['DesColis'],
numLivraison: snapshot.data![index]['numLivraison'],
typeColis: snapshot.data![index]['colisId']
['typeColis'],
poidsColis: snapshot.data![index]['colisId']
['poidsColis'],
etatLivraison: snapshot.data![index]['etatLivraison'],
sId: snapshot.data![index]['_id'],
idLivreur: snapshot.data![index]['livreur']['_id'],

imageUrl:snapshot.data![index]['imageUrl'] );

print(snapshot.data![index]['imageUrl'].toString());

Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
DetailLivraisonClient(livraison)));
},
);
},
itemCount: snapshot.data?.length,
);
} else {
return Center(
child: Text("ce numero n'est pas valide"),
);
}
},
),
),




],
), */