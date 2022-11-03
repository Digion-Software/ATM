import 'package:atm/config/api_endpoints.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/faq/faq_model.dart';
import 'package:atm/utils/networking/http_handler.dart';

class FAQRepository{
  static Future<FaqModel?> getFAQList() async {
    APIResponse apiResponse = await HttpHandler.getMethod(url: APIEndpoints.faq);
    if (apiResponse.isSuccess) {
      return faqModelFromJson(apiResponse.data);
    } else {
      return faqModelFromJson(apiResponse.data);
    }
  }
}