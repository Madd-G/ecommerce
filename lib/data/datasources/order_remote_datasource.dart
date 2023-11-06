import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/add_address_response_model.dart';
import 'package:ecommerce/data/models/responses/buyer_order_response_model.dart';
import 'package:ecommerce/data/models/responses/get_address_response_model.dart';
import 'package:ecommerce/data/models/responses/order_detail_response_model.dart';
import 'package:ecommerce/data/models/responses/order_response_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel request) async {
    final token = await AuthLocalDatasource().getToken();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return right(OrderResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  Future<Either<String, OrderDetailResponseModel>> getOrderById(
      String id) async {
    final token = await AuthLocalDatasource().getToken();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/orders/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(OrderDetailResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  Future<Either<String, BuyerOrderResponseModel>> getOrderByBuyerId() async {
    final token = await AuthLocalDatasource().getToken();
    final user = await AuthLocalDatasource().getUser();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/orders?filters[buyerId][\$eq]=${user.id}}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(BuyerOrderResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  //add address
  Future<Either<String, AddAddressResponseModel>> addAddress(
      AddAddressRequestModel request) async {
    final token = await AuthLocalDatasource().getToken();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/addresses'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return right(AddAddressResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  //get address by user id
  Future<Either<String, GetAddressResponseModel>> getAddressByUserId() async {
    final token = await AuthLocalDatasource().getToken();
    final user = await AuthLocalDatasource().getUser();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/addresses?filters[user_id][\$eq]=${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(GetAddressResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }
}
