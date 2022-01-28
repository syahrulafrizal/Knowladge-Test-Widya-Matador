import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widya_matador/componets/custom_dialog_question.dart';
import 'package:widya_matador/controllers/list_user_controller.dart';
import 'package:widya_matador/helper/constants.dart';
import 'package:widya_matador/helper/my_helper.dart';
import 'package:widya_matador/helper/screen.dart';
import 'package:widya_matador/pages/detail_user_page.dart';
import 'package:widya_matador/pages/form_user_page.dart';

class ListUserPage extends StatelessWidget {
  const ListUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    final listUserController = Get.put(ListUserController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: Text(
          "List Data User",
          style: TextStyle(
            fontSize: size.getWidthPx(16),
          ),
        ),
      ),
      body: Container(
        color: Constants.BACKGROUND_COLOR,
        child: Obx(
          () {
            return (listUserController.isLoading.value)
                ? const ContentLoading()
                : (listUserController.isError.value)
                    ? const ContentError()
                    : const ContentSuccess();
          },
        ),
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: !listUserController.isLoading.value,
          child: FloatingActionButton(
            onPressed: () async {
              dynamic result = await Get.to(
                () => const FormUserPage(data: null),
              );
              if (result != null) {
                listUserController.onRefresh();
              }
            },
            tooltip: 'Add',
            child: const Icon(Icons.add),
            backgroundColor: const Color(0xFF0D47A1),
          ),
        ),
      ),
    );
  }
}

class ContentSuccess extends StatelessWidget {
  const ContentSuccess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listUserController = Get.find<ListUserController>();
    return Obx(
      () => (listUserController.responseList.isNotEmpty)
          ? const ListData()
          : const DataEmpty(),
    );
  }
}

class DataEmpty extends StatelessWidget {
  const DataEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listUserController = Get.find<ListUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return SmartRefresher(
      controller: RefreshController(),
      onRefresh: () => listUserController.onRefresh(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            Constants.NOT_FOUND_IMAGE,
            width: size.getWidthPx(150),
            height: size.getWidthPx(150),
            fit: BoxFit.fill,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Center(
              child: Text(
                Constants.NODATA,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: size.getWidthPx(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListData extends StatelessWidget {
  const ListData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listUserController = Get.find<ListUserController>();
    return Obx(
      () => SmartRefresher(
        controller: RefreshController(),
        onRefresh: () => listUserController.onRefresh(),
        onLoading: () => listUserController.onLoadingMore(),
        enablePullUp: listUserController.nextPage.value != 0 ? true : false,
        child: ListView.separated(
          padding: const EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int index) {
            dynamic item = listUserController.responseList[index];
            return ItemData(item: item, index: index);
          },
          itemCount: listUserController.responseList.length,
          separatorBuilder: (BuildContext context, int index) {
            return MyHelpers.renderDivider();
          },
        ),
      ),
    );
  }
}

class ItemData extends StatelessWidget {
  const ItemData({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final dynamic item;
  final dynamic index;

  @override
  Widget build(BuildContext context) {
    final listUserController = Get.find<ListUserController>();
    Screen size = Screen(MediaQuery.of(context).size);
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey[700],
                    size: size.getWidthPx(25),
                  ),
                  title: Text(
                    'Detail Data',
                    style: TextStyle(
                      fontSize: size.getWidthPx(16),
                    ),
                  ),
                  onTap: () async {
                    Get.back();
                    Get.to(() => DetailUserpage(data: item));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Colors.grey[700],
                    size: size.getWidthPx(25),
                  ),
                  title: Text(
                    'Ubah Data',
                    style: TextStyle(
                      fontSize: size.getWidthPx(16),
                    ),
                  ),
                  onTap: () async {
                    Get.back();
                    dynamic result = await Get.to(
                      () => FormUserPage(data: item),
                    );
                    if (result != null) {
                      listUserController.onRefresh();
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Colors.grey[700],
                    size: size.getWidthPx(25),
                  ),
                  title: Text(
                    'Hapus Data',
                    style: TextStyle(
                      fontSize: size.getWidthPx(16),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    Get.generalDialog(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return CustomDialogQuestion(
                          title: "",
                          onTapOke: () async {
                            Get.back();
                            listUserController.onRemoveUser(item['user_id']);
                          },
                          desc:
                              "Apakahan Anda yakin ingin menghapus data user ?",
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: size.getWidthPx(12),
              bottom: size.getWidthPx(12),
              left: size.getWidthPx(16),
              right: size.getWidthPx(16),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    width: size.getWidthPx(45),
                    height: size.getWidthPx(45),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                      color: Colors.purple,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${item['user_initial']}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: size.getWidthPx(16),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.getWidthPx(14),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item['user_fullname']}",
                        style: TextStyle(
                          fontSize: size.getWidthPx(16),
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${item['user_mobilephone']}",
                        style: TextStyle(
                          fontSize: size.getWidthPx(12),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    final listUserController = Get.find<ListUserController>();
    Screen size = Screen(MediaQuery.of(context).size);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Obx(
          () => Image.asset(
            listUserController.errorImg.value,
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
                listUserController.errorMsg.value,
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
          onTap: () => listUserController.onRefresh(),
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
            child: Row(
              children: [
                Container(
                  width: size.getWidthPx(45),
                  height: size.getWidthPx(45),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: size.getWidthPx(14),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(
                        height: 8,
                      ),
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
                    ],
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
