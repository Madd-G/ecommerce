import 'package:ecommerce/core.dart';

part 'cart_event.dart';

part 'cart_state.dart';

part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const _Loaded([])) {
    on<_Add>((event, emit) {
      final currentState = state as _Loaded;
      //bila product ada di cart, maka tambahkan quantity
      final index = currentState.carts
          .indexWhere((element) => element.product.id == event.cart.product.id);
      if (index >= 0) {
        currentState.carts[index].quantity += 1;
        emit(const _Loading());
        emit(_Loaded(currentState.carts));
      } else {
        emit(_Loaded([...currentState.carts, event.cart]));
      }
    });

    // TODO: fix remove bug
    on<_Remove>((event, emit) {
      final currentState = state as _Loaded;
      //bila product ada di cart, maka dikurangi quantity
      final index = currentState.carts
          .indexWhere((element) => element.product.id == event.cart.product.id);
      if (index >= 0) {
        currentState.carts[index].quantity -= 1;
        List<CartModel> listCart = currentState.carts.toList();
        listCart.remove(event.cart);
        emit(_Loaded(listCart));
        if (currentState.carts[index].quantity <= 0) {
          currentState.carts.removeAt(index);
        }
        emit(const _Loading());
        // emit(_Loaded(currentState.carts));
        emit(_Loaded(listCart));
      }
    });

    on<_Started>((event, emit) {
      emit(const _Loading());
      emit(const _Loaded([]));
    });
  }
}
