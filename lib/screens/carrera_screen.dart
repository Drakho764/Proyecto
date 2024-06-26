import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/database/agendadb.dart';
import 'package:proyecto/models/carrera_model.dart';
import 'package:proyecto/screens/add_carrera.dart';
import 'package:proyecto/services/local_storage.dart';
import 'package:proyecto/widgets/CardCarreraWidget.dart';

class CarreraScreen extends StatefulWidget {
  const CarreraScreen({super.key});

  @override
  State<CarreraScreen> createState() => _CarreraScreenState();
}

class _CarreraScreenState extends State<CarreraScreen> {
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carreras"),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: ((context)=>  AddCarrera()))),
              icon: Icon(Icons.task))
        ],
      ),
      body: CustomRefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 3)),
        child: ValueListenableBuilder(
            valueListenable: LocalStorage.flagTask,
            builder: (context, value, _) {
              return FutureBuilder(
                  future: agendaDB!.GETALLCARRERA(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Carrera>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardCarreraWidget(
                                carreraModel: snapshot.data![index],
                                agendaDB: agendaDB);
                          });
                    } else {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("NO HAY CARRERAS REGISTRADAS"),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }
                  });
            }),
            builder: (BuildContext context, Widget child, IndicatorController controller) { return child; },
      ),
    );
  }
}
