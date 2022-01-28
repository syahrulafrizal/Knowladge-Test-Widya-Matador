import 'dart:collection';
import 'package:widya_matador/helper/api_service_helper.dart';
import 'package:widya_matador/helper/constants.dart';

import 'form_user_api_listener.dart';

class FormUserApiServices {
  FormUserApiListener mApiListener;
  FormUserApiServices(this.mApiListener);

  void onApiSuccess(responseBody, statusCode) {
    mApiListener.onFormUserSuccess(
      responseBody,
      statusCode,
    );
  }

  void onApiFailure(responseBody, statusCode) {
    mApiListener.onFormUserFailure(
      responseBody,
      statusCode,
    );
  }

  void onNoInternetConnection() {
    mApiListener.onNoInternetConnection();
  }

  postFormUser(
    String userId,
    String userFullname,
    String userShortname,
    String userMobilephone,
    String userEmail,
    String userGender,
    String userAddress,
    String userProfession,
  ) async {
    HashMap data = HashMap<String, dynamic>();
    data['user_id'] = userId;
    data['user_fullname'] = userFullname;
    data['user_shortname'] = userShortname;
    data['user_mobilephone'] = userMobilephone;
    data['user_email'] = userEmail;
    data['user_gender'] = userGender;
    data['user_address'] = userAddress;
    data['user_profession'] = userProfession;
    ApiServiceHelper().service(
      data,
      Constants.METHOD_TYPE_POST,
      userId == "0" ? "syahrul/create" : "syahrul/update",
      onApiSuccess,
      onApiFailure,
      onNoInternetConnection,
    );
  }
}
