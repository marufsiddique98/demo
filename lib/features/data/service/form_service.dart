import 'package:demo/core/client.dart';
import 'package:dio/dio.dart';

import '../models/models.dart';

class FormService {
  final ApiService apiService = ApiService();
  Future<FormModel> getFormResponse() async {
    try {
      Response response = await apiService.dioClient.getRequest(apiService.formUrl);
      if (response.statusCode == 200) {
        return FormModel.fromJson(response.data['json_response']);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return FormModel(attributes: []);
  }
}
