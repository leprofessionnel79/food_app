import 'package:food_app/data/repository/auth_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:get/get.dart';


class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(response.body["token"], true);
      print(response);
    } else {
      responseModel = ResponseModel(response.statusText!, false);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      print("my token is  " + response.body["token"]);
      responseModel = ResponseModel(response.body["token"], true);
    } else {
      responseModel = ResponseModel(response.statusText!, false);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberandPassword(String number, String password) {
    authRepo.saveUserNumberandPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
