import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:labapp/models/test_model.dart';

void showTestBottomSheet(BuildContext context) {
  final BookCaseController controller = Get.find<BookCaseController>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              "Select Tests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  controller.pagingController.refresh();
                  return Future.value();
                },
                child: PagedListView<int, Test>(
                  pagingController: controller.pagingController,
                  physics: AlwaysScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<Test>(
                    itemBuilder: (context, item, index) {
                      return Obx(
                        () => ListTile(
                          title: Text(item.name ?? ""),
                          subtitle: Text("₹ ${item.price}"),
                          trailing: Checkbox(
                            value: controller.selectedTests.any(
                              (element) => element.id == item.id,
                            ),
                            onChanged: (value) {
                              controller.toggleSelection(item);
                            },
                          ),
                          onTap: () {
                            controller.toggleSelection(item);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: elevatedButton(
                title: "Done",

                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
