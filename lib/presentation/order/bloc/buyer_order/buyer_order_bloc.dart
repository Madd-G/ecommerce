import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/buyer_order_response_model.dart';

part 'buyer_order_event.dart';
part 'buyer_order_state.dart';
part 'buyer_order_bloc.freezed.dart';

class BuyerOrderBloc extends Bloc<BuyerOrderEvent, BuyerOrderState> {
  BuyerOrderBloc() : super(const _Initial()) {
    on<_GetBuyerOrder>((event, emit) async {
      emit(const _Loading());
      final response = await OrderRemoteDatasource().getOrderByBuyerId();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
