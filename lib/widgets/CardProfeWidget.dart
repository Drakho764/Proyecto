import 'package:flutter/material.dart';
import 'package:proyecto/database/agendadb.dart';
import 'package:proyecto/models/profesor_model.dart';
import 'package:proyecto/screens/add_profe.dart';
import 'package:proyecto/services/local_storage.dart';

class CardProfesorWidget extends StatelessWidget {
  CardProfesorWidget({
    super.key,
    required this.profesor,
    this.agendaDB,
  });
  String car='';
  Profesor profesor;
  //String idcarrer=profesor.idCarrera.toString();
  AgendaDB? agendaDB;


  @override
  Widget build(BuildContext context) {
      switch(profesor.idCarrera){
   case 1:
     car='Sistemas';
    case 2:
      car='Quimica';
    case 3:
      car='Ambiental';
  };
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.grey),
      child: Row(
        children: [
          Column(
            children: [
              Text(profesor.nameProfe!),
              Text(profesor.email!),
              Text(car),
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
                              AddProfesor(profesor: profesor))),
                  child: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: const Text('¿Deseas eliminar AL PROFESOR?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETEPROF('tblProfesor', profesor!.idProfe!)
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
