import 'package:food_app/data/repository/auth_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/http/utils/body_decoder.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    print(signUpBody);
    _isLoading = true;

    Response response = await authRepo.registration(signUpBody);

    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(response.body["token"], true);
      print(response);
    } else {
      responseModel = ResponseModel(response.statusText!, false);
    }

    _isLoading = true;
    update();
    return responseModel;
  }
}
