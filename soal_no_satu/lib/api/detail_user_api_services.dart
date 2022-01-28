import 'dart:collection';
import 'package:widya_matador/helper/api_service_helper.dart';
import 'package:widya_matador/helper/constants.dart';

import 'detail_user_api_listener.dart';

class DetailUserApiServices {
  DetailUserApiListener mApiListener;
  DetailUserApiServices(this.mApiListener);

  void onApiSuccess(responseBody, statusCode) {
    mApiListener.onDetailUserSuccess(
      responseBody,
      statusCode,
    );
  }

  void onApiFailure(responseBody, statusCode) {
    mApiListener.onDetailUserFailure(
      responseBody,
      statusCode,
    );
  }

  void onNoInternetConnection() {
    mApiListener.onNoInternetConnection();
  }

  getDetailUser(
    String userId,
  ) async {
    HashMap data = HashMap<String, dynamic>();
    ApiServiceHelper().service(
      data,
      Constants.METHOD_TYPE_GET,
      "syahrul/single/$userId",
      onApiSuccess,
      onApiFailure,
      onNoInternetConnection,
    );
  }
}
