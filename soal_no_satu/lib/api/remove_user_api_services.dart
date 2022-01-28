import 'dart:collection';
import 'package:widya_matador/helper/api_service_helper.dart';
import 'package:widya_matador/helper/constants.dart';
import 'remove_user_api_listener.dart';

class RemoveUserApiServices {
  RemoveUserApiListener mApiListener;
  RemoveUserApiServices(this.mApiListener);

  void onApiSuccess(responseBody, statusCode) {
    mApiListener.onRemoveUserSuccess(
      responseBody,
      statusCode,
    );
  }

  void onApiFailure(responseBody, statusCode) {
    mApiListener.onRemoveUserFailure(
      responseBody,
      statusCode,
    );
  }

  void onNoInternetConnection() {
    mApiListener.onNoInternetConnection();
  }

  postRemoveUser(
    String userId,
  ) async {
    HashMap data = HashMap<String, dynamic>();
    data['user_id'] = userId;
    ApiServiceHelper().service(
      data,
      Constants.METHOD_TYPE_POST,
      "syahrul/remove",
      onApiSuccess,
      onApiFailure,
      onNoInternetConnection,
    );
  }
}
