import 'package:flutter/material.dart';
import 'package:proyecto/database/agendadb.dart';
import 'package:proyecto/models/carrera_model.dart';
import 'package:proyecto/screens/add_carrera.dart';
import 'package:proyecto/services/local_storage.dart';

class CardCarreraWidget extends StatelessWidget {
  CardCarreraWidget({super.key, required this.carreraModel, this.agendaDB});

  Carrera carreraModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.grey),
      child: Row(
        children: [
          Column(
            children: [
              Text(carreraModel.nameCarrera?? "null"),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddCarrera(carreraModel: carreraModel))),
                  child: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: const Text('¿Deseas eliminar la carrera?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETE(
                                          'tblCarrera', carreraModel.idCarrera!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    LocalStorage.flagTask.value =
                                        !LocalStorage.flagTask.value;
                                  });
                                },
                                child: Text('Si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No'))
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
