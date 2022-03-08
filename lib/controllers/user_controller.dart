import 'package:get/get.dart';

import 'package:food_app/data/repository/user_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/user_model.dart';

class UserController extends GetxController implements GetxService {
  UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late UserModel _userModel;

  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel("succefully", true);
    } else {
      responseModel = ResponseModel(response.statusText!, false);
    }

    

    update();
    return responseModel;
  }
}
