import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_cancha/data/implementations/functions_cubit_bloc.dart';
import 'package:prueba_cancha/domain/model/reservations_view_model.dart';

import '../../data/implementations/tennis_court_data_source_imp.dart';
import '../../domain/avaible_court_model.dart';
import 'add.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FunctionsCubitBloc>(
      create: (_) => FunctionsCubitBloc(context.read()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reservación de canchas'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddScreen()),
            );
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add),
        ),
        body: const LuistBuilder(),
      ),
    );
  }
}

class LuistBuilder extends StatefulWidget {
  const LuistBuilder({Key? key}) : super(key: key);

  @override
  State<LuistBuilder> createState() => _LuistBuilderState();
}

class _LuistBuilderState extends State<LuistBuilder> {
  late TennisCourtDataSourceImpl handler;
  List<ReservationView> all = [];
  @override
  void initState() {
    super.initState();
    handler = TennisCourtDataSourceImpl();
  }

  Future<List<AvaibleTCourt>?> avaibleTCourt(
      int id, String scheduledDate) async {
    return await handler.avaibleTCourt(id, scheduledDate);
  }

  Future<void> _onRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var response = BlocProvider.of<FunctionsCubitBloc>(context, listen: true);
    var items = response.state;
    return BlocListener<FunctionsCubitBloc, List<ReservationView>>(
      listener: ((context, state) => setState(() {
            items = response.state;
          })),
      child: Scrollbar(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: const Icon(Icons.delete_forever),
                ),
                key: ValueKey<String>(items[index].personName),
                onDismissed: (DismissDirection direction) async {
                  await handler.delete(items[index].id ?? 0);
                  setState(() {
                    items.remove(items[index]);
                  });
                },
                child: Card(
                    child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: Text(items[index].tCourtName),
                  title: Text(items[index].personName),
                  subtitle: Text(
                      "${items[index].scheduledDate?.year}-${items[index].scheduledDate?.month}-${items[index].scheduledDate?.day} de: ${items[index].scheduledHour} a ${items[index].scheduledHour + 2}"),
                  trailing: Text(items[index].rainfallRate.toString()),
                )),
              );
            },
          ),
        ),
      ),
    );
  }
}
