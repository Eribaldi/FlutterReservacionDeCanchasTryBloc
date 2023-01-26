import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_cancha/presentation/views/list.dart';

import 'data/implementations/tennis_court_data_source_imp.dart';
import 'data/interfaces/tennis_court_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TennisCourtDataSource>(
      create: (_) => TennisCourtDataSourceImpl(),
      child: MaterialApp(
        title: 'Reserva de canchas',
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const ListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
