import 'package:flutter/material.dart';
import 'package:widya_matador/api/list_user_api_listener.dart';
import 'package:widya_matador/api/list_user_api_services.dart';
import 'package:widya_matador/api/remove_user_api_listener.dart';
import 'package:widya_matador/api/remove_user_api_services.dart';
import 'package:widya_matador/componets/custom_dialog_information.dart';
import 'package:widya_matador/componets/custom_loader.dart';
import 'package:widya_matador/helper/constants.dart';
import 'package:get/get.dart';

class ListUserController extends GetxController
    implements ListUserApiListener, RemoveUserApiListener {
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;
  RxString errorMsg = Constants.ERROR_SERVER.obs;
  RxString errorImg = Constants.ERROR_IMAGE.obs;
  List responseList = [].obs;
  List filter = [].obs;
  RxInt nextPage = 0.obs;
  RxString search = "".obs;

  onRefresh() {
    isLoading.value = true;
    responseList.clear();
    nextPage.value = 1;
    isError.value = false;
    ListUserApiServices(this).getListUser(
      search.value,
      filter,
      1,
      10,
      "-user_id",
    );
  }

  onLoadingMore() {
    ListUserApiServices(this).getListUser(
      search.value,
      filter,
      nextPage.value,
      10,
      "-user_id",
    );
  }

  onRemoveUser(String userId) {
    Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return const CustomLoader();
      },
    );

    RemoveUserApiServices(this).postRemoveUser(userId);
  }

  @override
  void onInit() {
    ListUserApiServices(this).getListUser(
      search.value,
      filter,
      1,
      10,
      "-user_id",
    );
    super.onInit();
  }

  @override
  onListUserFailure(response, statusCode) {
    isLoading.value = false;
    isError.value = true;
    responseList.clear();
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
  onListUserSuccess(response, statusCode) {
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
    if (isLoading.value) {
      isLoading.value = false;
      isError.value = true;
      responseList.clear();
      errorMsg.value = Constants.NO_CONNECTION;
      errorImg.value = Constants.NOT_CONNECTION_IMAGE;
    } else {
      Get.back();
    }
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

  @override
  onRemoveUserFailure(response, statusCode) {
    Get.back();
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
  onRemoveUserSuccess(response, statusCode) {
    Get.back();
    if (response['status'] == 200) {
      onRefresh();
      Get.generalDialog(
        pageBuilder: (context, animation, secondaryAnimation) {
          return CustomDialogInformation(
            onTap: () {
              Get.back();
            },
            title: "${response['status']}",
            desc: "${response['message']}",
            color: Colors.green,
            icon: Icons.check_circle_outline,
          );
        },
      );
    } else {
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
}
