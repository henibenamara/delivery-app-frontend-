import 'package:flutter/material.dart';
import '../../constant/message_constants.dart';
import '../../models/client_list.dart';
import '../../services/clientService.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/drawer_responsable.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  List<ClientList> _ClientList = [];
  String _id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar,
      drawer: ResponsableDrawer(context),
      body: FutureBuilder(
        future: ClientService().getAllClient(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          print('snapshot is : ${snapshot.data}');

          if ((snapshot.hasData)) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['nom'].toString()),
                  subtitle: Text(snapshot.data![index]['prenom']),
                  trailing: Icon(Icons.star),
                    leading: CircleAvatar(backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/219/219986.png"))
                  /*,
               onTap: (){
                    Client.UserId user = new UserId(id: snapshot.data![index]['id'], email: snapshot.data![index]['email'], password: snapshot.data![index]['password'], role: snapshot.data![index]['role'], v: snapshot.data![index]['v']) as User;
                 Client client = new Client(
                     nom: snapshot.data![index]['nom'],
                     prenom: snapshot.data![index]['prenom'],
                     clientTel: snapshot.data![index]
                     ['clientTel'],
                     clientAdresse: snapshot.data![index]['clientAdresse'],
                   v: snapshot.data![index]['__v'],
                   id: snapshot.data![index]['_id'],
                   userId: user,


                     );
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) =>
                             DetailClient(client)));
                },*/
                );

              },
              itemCount: snapshot.data?.length,
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

  PreferredSize get appbar => PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppBar(
          title: const Text("liste de Client"),
          centerTitle: true,
        ),
      );

  Widget get showData => Column(
        children: <Widget>[
          newTaskPanel,
          crudPanel,
        ],
      );

  Widget get newTaskPanel => TaskPanel(
        widget: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                _ClientList.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return showCard(
                              index,
                              _ClientList[index].nom,
                              _ClientList[index].prenom,
                              _ClientList[index].clientTel,
                              _ClientList[index].clientAdresse,
                              _ClientList[index].userId,
                              _ClientList[index].id,
                              _ClientList[index].v,
                            );
                          },
                          itemCount: _ClientList.length,
                        ),
                      )
                    : const NoSavedData(),
              ],
            ),
          ),
        ),
      );

  Widget get crudPanel => Padding(
        padding: const EdgeInsets.only(bottom: 15),
      );

  Widget showCard(
    int index,
    String nom,
    String prenom,
    String clientTel,
    String clientAdresse,
    String userId,
    String id,
    String poidsColis,
  ) =>
      GestureDetector(
        onTap: () {
          _ClientList[index].nom;
          _ClientList[index].prenom;
          _ClientList[index].clientTel;
          _ClientList[index].clientAdresse;
          _ClientList[index].userId;
          _ClientList[index].id;
          _ClientList[index].v;
        },
        child: CustomCard(
          index: index + 1,
          name: nom,
          description: prenom,
          function: () async {
            _id = id;
          },
        ),
      );
}

class TaskPanel extends StatelessWidget {
  final Widget? widget;

  const TaskPanel({Key? key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return widget ?? const SizedBox.shrink();
  }
}

class ErrorOccurred extends StatelessWidget {
  const ErrorOccurred({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(MessageConstants.ERROR_OCCURED),
    );
  }
}

class NoSavedData extends StatelessWidget {
  const NoSavedData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.airline_seat_individual_suite,
          size: 55,
        ),
        const SizedBox(height: 15),
        Text(
          MessageConstants.NO_SAVED_DATA,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
