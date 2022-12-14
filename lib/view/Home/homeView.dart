import 'package:flutter/material.dart';
import 'package:money_search/data/MoneyController.dart';
import 'package:money_search/model/MoneyModel.dart';
import 'package:money_search/model/listPersonModel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

/// instancia do modelo para receber as informações
List<ListPersonModel> model = [];

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de pessoas'),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: FutureBuilder<List<ListPersonModel>>(
          future: MoneyController().getListPerson(),
          builder: (context, snapshot) {
            /// validação de carregamento da conexão
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            /// validação de erro
            if (snapshot.error == true) {
              return SizedBox(
                height: 300,
                child: Text("Vazio"),
              );
            }
//  List<ListPersonModel> model = [];
            /// passando informações para o modelo criado
            model = snapshot.data ?? model;
           
            model.removeWhere((pessoa) => pessoa.id == "64");
            model.removeWhere((pessoa) => pessoa.name == "Clay Wyman");
            model.add(ListPersonModel(id: "290", name: "Graziella chata", avatar: "https://static.imasters.com.br/wp-content/uploads/2018/05/30172759/macoratti-128x128.jpeg"));
            model.forEach((pessoa) { 
              if (pessoa.id == "9"){
                pessoa.avatar= "https://static.imasters.com.br/wp-content/uploads/2018/05/30172759/macoratti-128x128.jpeg";
                
            }
            else{} 
            });
            model.sort(
              (a, b) => a.name!.compareTo(b.name!),
            ); 
            
            return ListView.builder(
                itemCount: model.length,
                itemBuilder: (context, index) {
                  ListPersonModel item = model[index];

                  return ListTile(
                    leading: Image.network(
                      errorBuilder:(context, error, stackTrace) {
                        return Container();
                      },item.avatar ?? ""),
                    title: Text(item.name ?? ""),
                    trailing: Text(item.id ?? ""),
                  );
                });
            // ListView.builder(
            //   shrinkWrap: true,
            //   // physics: NeverScrollableScrollPhysics(),
            //   itemCount: model.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     ListPersonModel item = model[index];
            //     // tap(ListPersonModel item) {
            //     //   Navigator.push(
            //     //       context,
            //     //       MaterialPageRoute(
            //     //           builder: (context) => Person(
            //     //                 item: item,
            //     //               )));
            //     // }

            //     return GestureDetector(
            //       // onTap: (() => tap(item)),
            //       child: ListTile(
            //         leading: Image.network(item.avatar ?? ""),
            //         title: Text(item.name ?? ""),
            //         trailing: Text(item.id ?? ""),
            //       ),
            //     );
            //   },
            // );
          },
        ));
  }

  Future<Null> refresh() async {
    setState(() {});
  }
}
