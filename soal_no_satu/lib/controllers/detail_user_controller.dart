import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widya_matador/api/detail_user_api_listener.dart';
import 'package:widya_matador/api/detail_user_api_services.dart';
import 'package:widya_matador/componets/custom_dialog_information.dart';
import 'package:widya_matador/helper/constants.dart';

class DetailUserController extends GetxController
    implements DetailUserApiListener {
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;
  RxString errorMsg = Constants.ERROR_SERVER.obs;
  RxString errorImg = Constants.ERROR_IMAGE.obs;
  Rx<HashMap> dataUser = HashMap<dynamic, dynamic>().obs;

  onSetDataUser(data) {
    dataUser.value['user_id'] = data['user_id'];
    dataUser.value['user_fullname'] = data['user_fullname'];
    dataUser.value['user_shortname'] = data['user_shortname'];
    dataUser.value['user_mobilephone'] = data['user_mobilephone'];
    dataUser.value['user_email'] = data['user_email'];
    dataUser.value['user_gender'] = data['user_gender'];
    dataUser.value['user_address'] = data['user_address'];
    dataUser.value['user_profession'] = data['user_profession'];

    onRefresh();
  }

  onRefresh() {
    String userId = dataUser.value['user_id'];
    isLoading.value = true;
    isError.value = false;
    DetailUserApiServices(this).getDetailUser(userId);
  }

  @override
  onDetailUserFailure(response, statusCode) {
    isLoading.value = false;
    isError.value = true;
    errorMsg.value = response['message'];
    errorImg.value = Constants.ERROR_IMAGE;
    Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomDialogInformation(
          onTap: () {
            Get.back();
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
  onDetailUserSuccess(response, statusCode) {
    if (response['status'] == 200) {
      dynamic data = response['results']['data'];
      dataUser.value['user_id'] = data['user_id'];
      dataUser.value['user_fullname'] = data['user_fullname'];
      dataUser.value['user_shortname'] = data['user_shortname'];
      dataUser.value['user_mobilephone'] = data['user_mobilephone'];
      dataUser.value['user_email'] = data['user_email'];
      dataUser.value['user_gender'] = data['user_gender'];
      dataUser.value['user_address'] = data['user_address'];
      dataUser.value['user_profession'] = data['user_profession'];
      isError.value = false;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      isError.value = true;
      errorMsg.value = response['message'];
      errorImg.value = Constants.ERROR_IMAGE;
      Get.generalDialog(
        pageBuilder: (context, animation, secondaryAnimation) {
          return CustomDialogInformation(
            onTap: () {
              Get.back();
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
    errorMsg.value = Constants.NO_CONNECTION;
    errorImg.value = Constants.NOT_CONNECTION_IMAGE;

    Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomDialogInformation(
          onTap: () {
            Get.back();
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
