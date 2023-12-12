import 'package:flutter/material.dart';
import 'package:proyecto/database/agendadb.dart';
import 'package:proyecto/models/task_model.dart';
import 'package:proyecto/screens/add_task.dart';
import 'package:proyecto/services/local_storage.dart';

class CardTaskWidget extends StatelessWidget {
  CardTaskWidget({super.key, required this.taskModel, this.agendaDB});
  String profe='';
  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    switch(taskModel.idProfe){
   case 1:
     profe='Luisito Díaz';
    case 2:
      profe='Alberto del Rio';
  };
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.grey),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(taskModel.nameTask!,style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Text(taskModel.dscTask!, style: TextStyle( fontSize: 10),),
              SizedBox(height: 10,),
              
              Row(children: [Text('Se entrega el'),
                SizedBox(width: 12,),
                Text(taskModel.fecExpiracion!, style: TextStyle(
                      fontWeight: FontWeight.bold)),],),
              Row(children: [Text('Estado'),
                SizedBox(width: 12,),
                Text(taskModel.sttTask!, style: TextStyle(
                      fontWeight: FontWeight.bold)),],),
              Row(children: [Text('Profesor'),
                SizedBox(width: 12,),
                Text(profe, style: TextStyle(
                      fontWeight: FontWeight.bold)),],)
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTask(taskModel: taskModel))),
                  child: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: const Text('¿Deseas eliminar la tarea?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETE('tblTareas', taskModel.idTask!)
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
