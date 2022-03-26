import 'package:flutter/material.dart';

import '../../constant/message_constants.dart';
import '../../models/livraison_list.dart';
import '../../services/livraisonService.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/drawer.dart';
import 'DetailLivraison.dart';

class LivraisonPage extends StatefulWidget {
  const LivraisonPage({Key? key}) : super(key: key);

  @override
  _LivraisonPageState createState() => _LivraisonPageState();
}

class _LivraisonPageState extends State<LivraisonPage> {
  List<LivraisonList> _livraisonList = [];
  String _id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar,
      drawer: createDrawer(context),
      body: FutureBuilder(
        future: LivraisonService().getAllTLivraison(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          print('snapshot is : ${snapshot.data}');

          if ((snapshot.hasData)) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['numLivraison'].toString()),
                  subtitle: Text(snapshot.data![index]['AdressseDes']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailLivraison(snapshot.data![index])));
                  },
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
          title: const Text("liste de livraison"),
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
                _livraisonList.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return showCard(
                              index,
                              _livraisonList[index].numLivraison,
                              _livraisonList[index].adressseDes,
                              _livraisonList[index].adresseExp,
                              _livraisonList[index].dateDeLivraison,
                              _livraisonList[index].typeColis,
                              _livraisonList[index].DesColis,
                              _livraisonList[index].poidsColis,
                            );
                          },
                          itemCount: _livraisonList.length,
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
    String numLivraison,
    String adressseDes,
    String adresseExp,
    String dateDeLivraison,
    String sId,
    String desColis,
    String poidsColis,
  ) =>
      GestureDetector(
        onTap: () {
          _livraisonList[index].numLivraison;
          _livraisonList[index].adressseDes;
          _livraisonList[index].adresseExp;
          _livraisonList[index].dateDeLivraison;
          _livraisonList[index].typeColis;
          _livraisonList[index].DesColis;
          _livraisonList[index].poidsColis;
          _livraisonList[index].sId;
        },
        child: CustomCard(
          index: index + 1,
          name: numLivraison,
          description: adressseDes,
          function: () async {
            _id = sId;
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
  /*
class ListLivraison extends StatefulWidget {
  const ListLivraison({Key? key}) : super(key: key);

  @override
  State<ListLivraison> createState() => _ListLivraison();
}

class _ListLivraison extends State<ListLivraison> {

  @override
  void initState() {
    // TODO: implement initState
    var fetchData = Provider.of<getData>(context, listen: false);
    fetchData.getListData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    context.read<getData>().getListData();

    return Scaffold(
      appBar:AppBar(
        title: Text("List View Page"),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Center(
          child: Consumer<getData>(
              builder:(context,value,child){
                return value.data.isEmpty
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                    itemCount: value.data.length,
                    itemBuilder: (context,i){
                      return ListTile(
                        title: Text(value.data[i].id),
                        subtitle: Text(value.data[i].author),
                        trailing: Icon(Icons.more_vert_outlined),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>
                                  detailsView(
                                      id: (value.data[i].id),
                                      url: (value.data[i].url),
                                      author: (value.data[i].author),
                                      width: (value.data[i].width),
                                      height: (value.data[i].height))));
                        },
                      );
                    });
              }
          ),
        ),
      ),
    );
  }


  Future<void> _onRefresh() async{
    await Future.delayed(const Duration(seconds: 2));
    await context.read<getData>().getListData();

    setState(() {

    });
  }
}*/
}
