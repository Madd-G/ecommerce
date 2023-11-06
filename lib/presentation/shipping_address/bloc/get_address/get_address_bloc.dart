import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/get_address_response_model.dart';

part 'get_address_event.dart';

part 'get_address_state.dart';

part 'get_address_bloc.freezed.dart';

class GetAddressBloc extends Bloc<GetAddressEvent, GetAddressState> {
  GetAddressBloc() : super(const _Initial()) {
    on<_GetAddress>((event, emit) async {
      emit(const _Loading());
      final response = await OrderRemoteDatasource().getAddressByUserId();

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
