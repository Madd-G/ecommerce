import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final response = await AuthRemoteDatasource().login(event.data!);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
