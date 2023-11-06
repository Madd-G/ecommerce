import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/order_response_model.dart';

part 'order_event.dart';

part 'order_state.dart';

part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Initial()) {
    on<_Order>((event, emit) async {
      emit(const _Loading());
      final response = await OrderRemoteDatasource().order(event.request);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
