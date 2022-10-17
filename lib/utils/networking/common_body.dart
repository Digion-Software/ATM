import 'package:atm/config/app_constant.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';

class CommonBody {
  static Future<Map<String,dynamic>> authBody() async {
    return {
      "is_app": AppConstant.isApp,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token)
    };
  }
}
