import 'dart:collection';
import 'package:widya_matador/helper/api_service_helper.dart';
import 'package:widya_matador/helper/constants.dart';

import 'list_user_api_listener.dart';

class ListUserApiServices {
  ListUserApiListener mApiListener;
  ListUserApiServices(this.mApiListener);

  void onApiSuccess(responseBody, statusCode) {
    mApiListener.onListUserSuccess(
      responseBody,
      statusCode,
    );
  }

  void onApiFailure(responseBody, statusCode) {
    mApiListener.onListUserFailure(
      responseBody,
      statusCode,
    );
  }

  void onNoInternetConnection() {
    mApiListener.onNoInternetConnection();
  }

  getListUser(
    String search,
    List filter,
    int page,
    int limit,
    String sort,
  ) async {
    HashMap data = HashMap<String, dynamic>();
    data['search'] = search;
    data['filter'] = filter;
    data['page'] = page;
    data['limit'] = limit;
    data['sort'] = sort;
    ApiServiceHelper().service(
      data,
      Constants.METHOD_TYPE_GET,
      "syahrul/all",
      onApiSuccess,
      onApiFailure,
      onNoInternetConnection,
    );
  }
}
