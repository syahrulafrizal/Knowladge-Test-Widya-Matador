import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:widya_matador/componets/custom_dialog_question.dart';
import 'package:widya_matador/controllers/form_user_controller.dart';
import 'package:widya_matador/helper/constants.dart';
import 'package:widya_matador/helper/screen.dart';

class FormUserPage extends StatelessWidget {
  final dynamic data;
  const FormUserPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    final formUserController = Get.put(FormUserController());
    if (data != null && formUserController.dataUser.value.isEmpty) {
      formUserController.onSetDataUser(data);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: Obx(
          () => Text(
            formUserController.dataUser.value.isEmpty
                ? "Tambah Data User"
                : "Ubah Data User",
            style: TextStyle(
              fontSize: size.getWidthPx(16),
            ),
          ),
        ),
      ),
      body: Container(
        color: Constants.BACKGROUND_COLOR,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: const [
            InputFullName(),
            InputShortName(),
            InputPhonenumber(),
            InputEmail(),
            InputGender(),
            InputAddress(),
            InputJob(),
            ButtonSave(),
          ],
        ),
      ),
    );
  }
}

class InputFullName extends StatelessWidget {
  const InputFullName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formUserController = Get.find<FormUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: Obx(
        () => TextField(
          controller: formUserController.inputFullName,
          cursorColor: const Color(0xFF0D47A1),
          style: TextStyle(
            fontSize: size.getWidthPx(14),
            color: Colors.grey.shade800,
          ),
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(
              0.0,
              0.0,
              0.0,
              0.0,
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0D47A1)),
            ),
            labelText: "Nama Lengkap",
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: size.getWidthPx(14),
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.getWidthPx(14),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            errorText: !formUserController.validateFullName.value
                ? formUserController.msgFullName.value
                : null,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontStyle: FontStyle.italic,
              fontSize: size.getWidthPx(10),
            ),
          ),
        ),
      ),
    );
  }
}

class InputShortName extends StatelessWidget {
  const InputShortName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formUserController = Get.find<FormUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: Obx(
        () => TextField(
          controller: formUserController.inputShortName,
          cursorColor: const Color(0xFF0D47A1),
          style: TextStyle(
            fontSize: size.getWidthPx(14),
            color: Colors.grey.shade800,
          ),
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(
              0.0,
              0.0,
              0.0,
              0.0,
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0D47A1)),
            ),
            labelText: "Nama Panggilan",
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: size.getWidthPx(14),
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.getWidthPx(14),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            errorText: !formUserController.validateShortName.value
                ? formUserController.msgShortName.value
                : null,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontStyle: FontStyle.italic,
              fontSize: size.getWidthPx(10),
            ),
          ),
        ),
      ),
    );
  }
}

class InputPhonenumber extends StatelessWidget {
  const InputPhonenumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formUserController = Get.find<FormUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: Obx(
        () => TextField(
          controller: formUserController.inputPhonenumber,
          cursorColor: const Color(0xFF0D47A1),
          style: TextStyle(
            fontSize: size.getWidthPx(14),
            color: Colors.grey.shade800,
          ),
          autofocus: false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(
              0.0,
              0.0,
              0.0,
              0.0,
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0D47A1)),
            ),
            labelText: "Nomor Handphone",
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: size.getWidthPx(14),
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.getWidthPx(14),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            errorText: !formUserController.validatePhonenumber.value
                ? formUserController.msgPhonenumber.value
                : null,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontStyle: FontStyle.italic,
              fontSize: size.getWidthPx(10),
            ),
          ),
        ),
      ),
    );
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formUserController = Get.find<FormUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: Obx(
        () => TextField(
          controller: formUserController.inputEmail,
          cursorColor: const Color(0xFF0D47A1),
          style: TextStyle(
            fontSize: size.getWidthPx(14),
            color: Colors.grey.shade800,
          ),
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(
              0.0,
              0.0,
              0.0,
              0.0,
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0D47A1)),
            ),
            labelText: "Email",
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: size.getWidthPx(14),
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.getWidthPx(14),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            errorText: !formUserController.validateEmail.value
                ? formUserController.msgEmail.value
                : null,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontStyle: FontStyle.italic,
              fontSize: size.getWidthPx(10),
            ),
          ),
        ),
      ),
    );
  }
}

class InputGender extends StatelessWidget {
  const InputGender({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formUserController = Get.find<FormUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    MdiIcons.faceMan,
                    color: Colors.grey[700],
                    size: size.getWidthPx(25),
                  ),
                  title: Text(
                    'Laki-Laki',
                    style: TextStyle(
                      fontSize: size.getWidthPx(16),
                    ),
                  ),
                  onTap: () async {
                    Get.back();
                    formUserController.onSelectGender("Laki-Laki");
                  },
                ),
                ListTile(
                  leading: Icon(
                    MdiIcons.faceWoman,
                    color: Colors.grey[700],
                    size: size.getWidthPx(25),
                  ),
                  title: Text(
                    'Perempuan',
                    style: TextStyle(
                      fontSize: size.getWidthPx(16),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    formUserController.onSelectGender("Perempuan");
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: size.getWidthPx(16)),
        padding: EdgeInsets.symmetric(
          horizontal: size.getWidthPx(16),
        ),
        child: Obx(
          () => TextField(
            controller: formUserController.inputGender,
            cursorColor: const Color(0xFF0D47A1),
            style: TextStyle(
              fontSize: size.getWidthPx(14),
              color: Colors.grey.shade800,
            ),
            autofocus: false,
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                0.0,
                0.0,
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF0D47A1)),
              ),
              labelText: "Jenis Kelamin",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: size.getWidthPx(14),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorText: !formUserController.validateGender.value
                  ? formUserController.msgGender.value
                  : null,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontSize: size.getWidthPx(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputAddress extends StatelessWidget {
  const InputAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formUserController = Get.find<FormUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: Obx(
        () => TextField(
          controller: formUserController.inputAddress,
          cursorColor: const Color(0xFF0D47A1),
          style: TextStyle(
            fontSize: size.getWidthPx(14),
            color: Colors.grey.shade800,
          ),
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(
              0.0,
              0.0,
              0.0,
              0.0,
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0D47A1)),
            ),
            labelText: "Alamat",
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: size.getWidthPx(14),
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.getWidthPx(14),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            errorText: !formUserController.validateAddress.value
                ? formUserController.msgAddress.value
                : null,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontStyle: FontStyle.italic,
              fontSize: size.getWidthPx(10),
            ),
          ),
        ),
      ),
    );
  }
}

class InputJob extends StatelessWidget {
  const InputJob({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formUserController = Get.find<FormUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: Obx(
        () => TextField(
          controller: formUserController.inputJob,
          cursorColor: const Color(0xFF0D47A1),
          style: TextStyle(
            fontSize: size.getWidthPx(14),
            color: Colors.grey.shade800,
          ),
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(
              0.0,
              0.0,
              0.0,
              0.0,
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0D47A1)),
            ),
            labelText: "Pekerjaan",
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: size.getWidthPx(14),
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.getWidthPx(14),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            errorText: !formUserController.validateJob.value
                ? formUserController.msgJob.value
                : null,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontStyle: FontStyle.italic,
              fontSize: size.getWidthPx(10),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonSave extends StatelessWidget {
  const ButtonSave({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formUserController = Get.find<FormUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(
        top: size.getWidthPx(32),
        bottom: size.getWidthPx(32),
        left: size.getWidthPx(16),
        right: size.getWidthPx(16),
      ),
      child: Obx(
        () => ElevatedButton(
          onPressed: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            dynamic result = await formUserController.onValidationFormInput();
            if (result != null && result) {
              Get.generalDialog(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return CustomDialogQuestion(
                    title: "",
                    onTapOke: () async {
                      Get.back();
                      formUserController.onSaveData();
                    },
                    desc: formUserController.dataUser.value.isEmpty
                        ? "Apakahan Anda yakin ingin menyimpan data user ?"
                        : "Apakahan Anda yakin ingin menyimpan data perubahan user ?",
                  );
                },
              );
            }
          },
          child: Text(
            formUserController.dataUser.value.isEmpty
                ? "Simpan Data"
                : "Simpan Perubahan Data",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.getWidthPx(14),
            ),
          ),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.infinity, size.getWidthPx(40)),
            primary: Colors.blue[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(
              vertical: size.getWidthPx(10),
              horizontal: size.getWidthPx(14),
            ),
          ),
        ),
      ),
    );
  }
}
