import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/cost_response_model.dart';

part 'get_cost_event.dart';

part 'get_cost_state.dart';

part 'get_cost_bloc.freezed.dart';

class GetCostBloc extends Bloc<GetCostEvent, GetCostState> {
  GetCostBloc() : super(const _Initial()) {
    on<_GetCost>((event, emit) async {
      emit(const _Loading());
      debugPrint('origin: ${event.origin}');
      debugPrint('destination: ${event.destination}');
      debugPrint('courier: ${event.courier}');

      final response = await RajaOngkirRemoteDatasource().getCost(
        event.origin,
        event.destination,
        event.courier,
      );
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
