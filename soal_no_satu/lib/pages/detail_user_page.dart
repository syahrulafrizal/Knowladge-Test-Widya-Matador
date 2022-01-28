import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widya_matador/controllers/detail_user_controller.dart';
import 'package:widya_matador/helper/constants.dart';
import 'package:widya_matador/helper/my_helper.dart';
import 'package:widya_matador/helper/screen.dart';

class DetailUserpage extends StatelessWidget {
  final dynamic data;
  const DetailUserpage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    final detailUserController = Get.put(DetailUserController());
    if (data != null && detailUserController.dataUser.value.isEmpty) {
      detailUserController.onSetDataUser(data);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: Text(
          "Data Detail User",
          style: TextStyle(
            fontSize: size.getWidthPx(16),
          ),
        ),
      ),
      body: Container(
        color: Constants.BACKGROUND_COLOR,
        child: Obx(
          () {
            return (detailUserController.isLoading.value)
                ? const ContentLoading()
                : (detailUserController.isError.value)
                    ? const ContentError()
                    : const ContentSuccess();
          },
        ),
      ),
    );
  }
}

class ContentSuccess extends StatelessWidget {
  const ContentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailtUserController = Get.find<DetailUserController>();
    final item = detailtUserController.dataUser.value;
    return SmartRefresher(
      controller: RefreshController(),
      onRefresh: () => detailtUserController.onRefresh(),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          ItemDetailUser(
            label: 'Nama Lengkap :',
            value: '${item['user_fullname']}',
          ),
          MyHelpers.renderDivider(),
          ItemDetailUser(
            label: 'Nama Panggilan :',
            value: '${item['user_shortname']}',
          ),
          MyHelpers.renderDivider(),
          ItemDetailUser(
            label: 'Nomor Handphone :',
            value: '${item['user_mobilephone']}',
          ),
          MyHelpers.renderDivider(),
          ItemDetailUser(
            label: 'Email :',
            value: '${item['user_email']}',
          ),
          MyHelpers.renderDivider(),
          ItemDetailUser(
            label: 'Jenis Kelamin :',
            value: '${item['user_gender']}',
          ),
          MyHelpers.renderDivider(),
          ItemDetailUser(
            label: 'Alamat :',
            value: '${item['user_address']}',
          ),
          MyHelpers.renderDivider(),
          ItemDetailUser(
            label: 'Pekerjaan :',
            value: '${item['user_profession']}',
          ),
          MyHelpers.renderDivider(),
        ],
      ),
    );
  }
}

class ItemDetailUser extends StatelessWidget {
  const ItemDetailUser({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(
        top: size.getWidthPx(16),
        bottom: size.getWidthPx(16),
        left: size.getWidthPx(16),
        right: size.getWidthPx(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: size.getWidthPx(12),
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: size.getWidthPx(15),
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class ContentError extends StatelessWidget {
  const ContentError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailtUserController = Get.find<DetailUserController>();
    Screen size = Screen(MediaQuery.of(context).size);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Obx(
          () => Image.asset(
            detailtUserController.errorImg.value,
            width: size.getWidthPx(150),
            height: size.getWidthPx(150),
            fit: BoxFit.fill,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Center(
            child: Obx(
              () => Text(
                detailtUserController.errorMsg.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: size.getWidthPx(14),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => detailtUserController.onRefresh(),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(100.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: size.getWidthPx(64)),
            padding: EdgeInsets.symmetric(
              vertical: size.getWidthPx(12),
              horizontal: size.getWidthPx(14),
            ),
            child: Text(
              "Coba Lagi",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContentLoading extends StatelessWidget {
  const ContentLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemBuilder: (BuildContext context, int index) {
        return const ItemLoading();
      },
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return MyHelpers.renderDivider();
      },
    );
  }
}

class ItemLoading extends StatelessWidget {
  const ItemLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Shimmer.fromColors(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: size.getWidthPx(16),
              bottom: size.getWidthPx(16),
              left: size.getWidthPx(16),
              right: size.getWidthPx(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.getWidthPx(10),
                  width: size.wp(50),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: size.getWidthPx(10),
                  width: size.wp(70),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
    );
  }
}
