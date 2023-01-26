import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_cancha/data/interfaces/tennis_court_data.dart';

import '../../domain/model/reservations_view_model.dart';

class FunctionsCubitBloc extends Cubit<List<ReservationView>> {
  final TennisCourtDataSource tennisCourtRepository;

  FunctionsCubitBloc(this.tennisCourtRepository) : super(<ReservationView>[]);

  Future<void> getAllReservations() async {
    final result = await tennisCourtRepository.getAll();
    emit(result);
  }
}
