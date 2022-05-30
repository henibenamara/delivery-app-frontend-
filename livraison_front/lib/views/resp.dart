import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/views/responsable/demandeLivreur.dart';



import '../widgets/drawer_responsable.dart';
import 'livraison/livraisonList.dart';



class responsable extends StatefulWidget {

  @override
  _responsable createState() => _responsable();
}
class _responsable extends State<responsable> {
  TextEditingController num = TextEditingController();
  String? numliv="1";
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueAccent),
        drawer: ResponsableDrawer(context),
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
                  child: InkWell(
                    onTap: () async {
                    /*  await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DashboardAdmin()));*/
                    },
                  child: Row(
                    children: [
                      CircleAvatar(backgroundImage: AssetImage("assets/images/box.png"),radius: 50,backgroundColor: Colors.white,),
                      SizedBox(width: 10,),
                      Text("Dashboard",style: TextStyle(fontSize: 28),),

                    ],
                  ),
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
                                  DemandeLivreur()));
                    },
                  child: Row(
                    children: [
                      CircleAvatar(backgroundImage: AssetImage("assets/images/box.png"),radius: 50,backgroundColor: Colors.white,),
                      SizedBox(width: 10,),
                      Text("demande de livreur",style: TextStyle(fontSize: 28),),

                    ],
                  ),
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
                          LivraisonPage()));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(backgroundImage: AssetImage("assets/images/box.png"),radius: 50,backgroundColor: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Historique generale",style: TextStyle(fontSize: 28),),

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
