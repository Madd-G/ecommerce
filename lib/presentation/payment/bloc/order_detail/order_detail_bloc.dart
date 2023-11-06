import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/order_detail_response_model.dart';

part 'order_detail_event.dart';

part 'order_detail_state.dart';

part 'order_detail_bloc.freezed.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc() : super(const _Initial()) {
    on<_GetOrderDetail>((event, emit) async {
      emit(const _Loading());
      final response =
          await OrderRemoteDatasource().getOrderById(event.orderId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
