import 'package:flutter/material.dart';
import 'package:proyecto/database/agendadb.dart';
import 'package:proyecto/models/task_model.dart';
import 'package:proyecto/screens/add_task.dart';
import 'package:proyecto/screens/provider_screen.dart';
import 'package:proyecto/services/local_storage.dart';
import 'package:proyecto/widgets/CardTaskWidget.dart';
import 'package:proyecto/widgets/dropdown_widget.dart';
import 'package:proyecto/widgets/filter_text_dialog.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  AgendaDB? agendaDB;
  List<String> dropDownValues = [];
  DropDownWidget? dropDownFilter;
  String filtro = "Todo";

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    dropDownValues = ['Pendiente', 'Completado', 'En proceso', 'Todo'];
    dropDownFilter = DropDownWidget(controller: 'Todo', values: dropDownValues);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tareas"),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: ((context)=> AddTask()))),
              icon: Icon(Icons.task)),
              /*IconButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: ((context)=> FilterTextWidget()))),
              icon: Icon(Icons.search)),*/
          DropdownButton<String>(
            value: filtro,
            icon: const Icon(Icons.filter_list),
            onChanged: (String? newValue) {
              setState(() {
                filtro = newValue!;
              });
            },
            items: <String>['Pendiente', 'Completado', 'En proceso', 'Todo']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: LocalStorage.flagTask,
          builder: (context, value, _) {
            return FutureBuilder(
                future: _getTareas(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TaskModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardTaskWidget(
                              taskModel: snapshot.data![index],
                              agendaDB: agendaDB);
                        });
                  } else {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something was wrong"),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                });
          }),
    );
  }

  Future<List<TaskModel>> _getTareas() {
    switch (filtro) {
      case 'Completado':
        return agendaDB!.ListarTareasRealizadas();
      case 'Pendiente':
        return agendaDB!.ListarTareasPendientes();
      case 'En proceso':
        return agendaDB!.ListarTareasProceso();
      default:
        return agendaDB!.GETALLTASK();
    }
  }
}