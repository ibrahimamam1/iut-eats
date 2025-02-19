import 'package:get/get.dart';
import 'package:iut_eats/data/repository/auth_repo.dart';
import 'package:iut_eats/models/response_model.dart';

import '../data/repository/user_repo.dart';
import '../models/user_model.dart';


class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  late UserModel _userModel;
  bool get isLoading =>_isLoading;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    _isLoading=true;
    update();
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if(response.statusCode==200){
      _userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, "successfully");
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading=false;
    update();
    return responseModel;
  }


}