import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/products_response_model.dart';

part 'products_event.dart';

part 'products_state.dart';

part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDatasource().getAllProduct();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
