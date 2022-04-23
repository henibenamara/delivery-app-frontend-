import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/models/client.dart';
import 'package:livraison_front/views/client/EditClient.dart';

import '../../constant/app_constants.dart';
import '../../services/clientService.dart';
import '../../widgets/profile_Widget.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(this.userId);

  final String? userId;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? get userId => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Profile"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [

              Container(
                height: 1000,
                child: FutureBuilder(
                  future: ClientService().getClientByIdUSer(widget.userId),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    print('snapshot is : ${snapshot.data}');

                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildCard(context, index));
                    } else {
                      return const Center(
                          child: Text("",
                              style: TextStyle(fontSize: 1))); // Center

                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, int index) {
    return FutureBuilder(
        future: ClientService().getClientByIdUSer(widget.userId),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Column(

                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDihWg7BJ59mXCACdRk0gDNNqu0-1S77xWpA&usqp=CAU"
                            ),
                            fit: BoxFit.cover
                        )
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Container(
                        alignment: Alignment(0.0,2.5),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              AppConstants.API_URL+"/"+snapshot.data![index]["image"]
                          ),
                          radius: 60.0,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    snapshot.data![index]["nom"]+" "+snapshot.data![index]["prenom"]
                    ,style: TextStyle(
                      fontSize: 25.0,
                      color:Colors.blueGrey,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w400
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index]["clientAdresse"]
                    ,style: TextStyle(
                      fontSize: 18.0,
                      color:Colors.black45,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "telephone :"+snapshot.data![index]["clientTel"].toString()
                    ,style: TextStyle(
                      fontSize: 15.0,
                      color:Colors.black45,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    ""
                    ,style: TextStyle(
                      fontSize: 18.0,
                      color:Colors.black45,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300
                  ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text("Livraisons",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600
                                  ),),
                                SizedBox(
                                  height: 7,
                                ),
                                Text("15",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w300
                                  ),)
                              ],
                            ),
                          ),
                          Expanded(
                            child:
                            Column(
                              children: [
                                Text("Scores",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600
                                  ),),
                                SizedBox(
                                  height: 7,
                                ),
                                Text("27",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w300
                                  ),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      RaisedButton(
                        onPressed: (){
                          Client cli = new Client(
                            nom: snapshot.data![index]['nom'],
                            prenom: snapshot.data![index]['prenom'],
                            clientAdresse: snapshot.data![index]
                            ['clientAdresse'],
                            clientTel: snapshot.data![index]['clientTel'],
                            id: snapshot.data![index]['_id'],
                            imageUrl: AppConstants.API_URL+"/"+snapshot.data![index]['image'],
                            v: snapshot.data![index]['__v'],
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfileClient(cli)));

                        },
                        shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.pink,Colors.redAccent]
                            ),
                            borderRadius: BorderRadius.circular(80.0),

                          ),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                            alignment: Alignment.center,
                            child: Text(
                              "Modifier ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Center(
                child: Text(" ", style: TextStyle(fontSize: 1))); // Center

          }
        });
  }
}
