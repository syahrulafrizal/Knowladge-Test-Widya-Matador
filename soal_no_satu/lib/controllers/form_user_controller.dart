import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widya_matador/api/form_user_api_listener.dart';
import 'package:widya_matador/api/form_user_api_services.dart';
import 'package:widya_matador/componets/custom_dialog_information.dart';
import 'package:widya_matador/componets/custom_loader.dart';
import 'package:widya_matador/helper/constants.dart';
import 'package:widya_matador/helper/my_helper.dart';

class FormUserController extends GetxController implements FormUserApiListener {
  TextEditingController inputFullName = TextEditingController();
  RxBool validateFullName = true.obs;
  RxString msgFullName = "".obs;

  TextEditingController inputShortName = TextEditingController();
  RxBool validateShortName = true.obs;
  RxString msgShortName = "".obs;

  TextEditingController inputPhonenumber = TextEditingController();
  RxBool validatePhonenumber = true.obs;
  RxString msgPhonenumber = "".obs;

  TextEditingController inputEmail = TextEditingController();
  RxBool validateEmail = true.obs;
  RxString msgEmail = "".obs;

  TextEditingController inputGender = TextEditingController();
  RxBool validateGender = true.obs;
  RxString msgGender = "".obs;

  TextEditingController inputAddress = TextEditingController();
  RxBool validateAddress = true.obs;
  RxString msgAddress = "".obs;

  TextEditingController inputJob = TextEditingController();
  RxBool validateJob = true.obs;
  RxString msgJob = "".obs;

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

    inputFullName.value = TextEditingValue(
      text: data['user_fullname'],
      selection: TextSelection.collapsed(offset: data['user_fullname'].length),
    );
    inputShortName.value = TextEditingValue(
      text: data['user_shortname'],
      selection: TextSelection.collapsed(offset: data['user_shortname'].length),
    );
    inputPhonenumber.value = TextEditingValue(
      text: data['user_mobilephone'],
      selection:
          TextSelection.collapsed(offset: data['user_mobilephone'].length),
    );
    inputEmail.value = TextEditingValue(
      text: data['user_email'],
      selection: TextSelection.collapsed(offset: data['user_email'].length),
    );
    inputGender.value = TextEditingValue(
      text: data['user_gender'],
      selection: TextSelection.collapsed(offset: data['user_gender'].length),
    );
    inputAddress.value = TextEditingValue(
      text: data['user_address'],
      selection: TextSelection.collapsed(offset: data['user_address'].length),
    );
    inputJob.value = TextEditingValue(
      text: data['user_profession'],
      selection:
          TextSelection.collapsed(offset: data['user_profession'].length),
    );
  }

  onSelectGender(value) => inputGender.value = TextEditingValue(text: value);

  onValidationFormInput() {
    String valueFullName = inputFullName.text.toString().trim();
    String valueShortName = inputShortName.text.toString().trim();
    String valuePhonenumber = inputPhonenumber.text.toString().trim();
    String valueEmail = inputEmail.text.toString().trim();
    String valueGender = inputGender.text.toString().trim();
    String valueAddress = inputAddress.text.toString().trim();
    String valueJob = inputJob.text.toString().trim();

    if (valueFullName.isEmpty) {
      validateFullName.value = false;
      msgFullName.value = "Nama lengkap tidak boleh kosong";
    } else {
      validateFullName.value = true;
      msgFullName.value = "";
    }

    if (valueShortName.isEmpty) {
      validateShortName.value = false;
      msgShortName.value = "Nama panggilan tidak boleh kosong";
    } else {
      validateShortName.value = true;
      msgShortName.value = "";
    }

    if (valuePhonenumber.isEmpty) {
      validatePhonenumber.value = false;
      msgPhonenumber.value = "Nomor handphone tidak boleh kosong";
    } else {
      validatePhonenumber.value = true;
      msgPhonenumber.value = "";
    }

    if (valueEmail.isEmpty) {
      validateEmail.value = false;
      msgEmail.value = "Email tidak boleh kosong";
    } else {
      if (!MyHelpers.validateEmail(valueEmail)) {
        validateEmail.value = false;
        msgEmail.value = "Email tidak valid";
      } else {
        validateEmail.value = true;
        msgEmail.value = "";
      }
    }

    if (valueGender.isEmpty) {
      validateGender.value = false;
      msgGender.value = "Jenis Kelamin tidak boleh kosong";
    } else {
      validateGender.value = true;
      msgGender.value = "";
    }

    if (valueAddress.isEmpty) {
      validateAddress.value = false;
      msgAddress.value = "Alamat tidak boleh kosong";
    } else {
      validateAddress.value = true;
      msgAddress.value = "";
    }

    if (valueJob.isEmpty) {
      validateJob.value = false;
      msgJob.value = "Pekerjaan tidak boleh kosong";
    } else {
      validateJob.value = true;
      msgJob.value = "";
    }

    if (validateFullName.value &&
        validateShortName.value &&
        validatePhonenumber.value &&
        validateEmail.value &&
        validateGender.value &&
        validateAddress.value &&
        validateJob.value) {
      return true;
    }

    return false;
  }

  onSaveData() {
    Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return const CustomLoader();
      },
    );

    String valueFullName = inputFullName.text.toString().trim();
    String valueShortName = inputShortName.text.toString().trim();
    String valuePhonenumber = inputPhonenumber.text.toString().trim();
    String valueEmail = inputEmail.text.toString().trim();
    String valueGender = inputGender.text.toString().trim();
    String valueAddress = inputAddress.text.toString().trim();
    String valueJob = inputJob.text.toString().trim();
    String userId = "0";

    if (dataUser.value.isNotEmpty) {
      userId = dataUser.value['user_id'];
    }

    FormUserApiServices(this).postFormUser(
      userId,
      valueFullName,
      valueShortName,
      valuePhonenumber,
      valueEmail,
      valueGender,
      valueAddress,
      valueJob,
    );
  }

  @override
  onFormUserFailure(response, statusCode) {
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
  onFormUserSuccess(response, statusCode) {
    Get.back();
    if (response['status'] == 200) {
      Get.back(result: response);
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

  @override
  onNoInternetConnection() {
    Get.back();
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
