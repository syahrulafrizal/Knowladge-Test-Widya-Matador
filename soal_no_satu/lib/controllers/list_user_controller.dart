import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:widya_matador/api/list_user_api_listener.dart';
import 'package:widya_matador/api/list_user_api_services.dart';
import 'package:widya_matador/componets/custom_dialog_information.dart';
import 'package:widya_matador/helper/constants.dart';
import 'package:get/get.dart';

class ListUserController extends GetxController implements ListUserApiListener {
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;
  RxString errorMsg = Constants.ERROR_SERVER.obs;
  RxString errorImg = Constants.ERROR_IMAGE.obs;
  List responseList = [].obs;
  List filter = [].obs;
  RxInt nextPage = 0.obs;
  RxString search = "".obs;

  void onRefresh() {
    isLoading.value = true;
    responseList.clear();
    nextPage.value = 1;
    isError.value = false;
    ListUserApiServices(this).getListUser(
      search.value,
      filter,
      1,
      10,
      "user_id",
    );
  }

  void onLoadingMore() {
    ListUserApiServices(this).getListUser(
      search.value,
      filter,
      nextPage.value,
      10,
      "user_id",
    );
  }

  @override
  void onInit() {
    ListUserApiServices(this).getListUser(
      search.value,
      filter,
      1,
      10,
      "user_id",
    );
    super.onInit();
  }

  @override
  onListUserFailure(response, statusCode) {
    // log(response.toString());
    isLoading.value = false;
    isError.value = true;
    responseList.clear();
    errorMsg.value = response['message'];
    errorImg.value = Constants.ERROR_IMAGE;
    Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomDialogInformation(
          onTap: () {
            Navigator.pop(context);
          },
          title: "Failed",
          desc: "${response['message']}",
          color: Colors.red,
          icon: Icons.error_outline,
        );
      },
    );
  }

  @override
  onListUserSuccess(response, statusCode) {
    log(response.toString());
    if (response['status'] == 200) {
      List tempList = [];
      for (var item in response['results']['data']) {
        tempList.add(item);
      }
      responseList.addAll(tempList);
      nextPage.value = response['results']['pagination']['next'];
      isError.value = false;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      isError.value = true;
      responseList.clear();
      errorMsg.value = response['message'];
      errorImg.value = Constants.NOT_CONNECTION_IMAGE;
      Get.generalDialog(
        pageBuilder: (context, animation, secondaryAnimation) {
          return CustomDialogInformation(
            onTap: () {
              Navigator.pop(context);
            },
            title: "${response['status']}",
            desc: "${response['message']}",
            color: Colors.orange,
            icon: Icons.error_outline,
          );
        },
      );
    }
  }

  @override
  onNoInternetConnection() {
    isLoading.value = false;
    isError.value = true;
    responseList.clear();
    errorMsg.value = Constants.NO_CONNECTION;
    errorImg.value = Constants.NOT_CONNECTION_IMAGE;
    Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomDialogInformation(
          onTap: () {
            Navigator.pop(context);
          },
          title: "Failed",
          desc: Constants.NO_CONNECTION,
          color: Colors.orange,
          icon: Icons.error_outline,
        );
      },
    );
  }
}
