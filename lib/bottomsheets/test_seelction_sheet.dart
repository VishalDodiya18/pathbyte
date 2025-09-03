import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:labapp/models/group_test_model.dart';
import 'package:labapp/models/test_model.dart';

void showTestBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return GetBuilder<BookCaseController>(
        builder: (controller) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              children: [
                const SizedBox(height: 12),
                const Text(
                  "Select Tests",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    controller: controller.searchcontrller,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      EasyDebounce.debounce(
                        'test-search-debouncer',
                        Duration(milliseconds: 500),
                        () {
                          controller.pagingController.refresh();
                          controller.grouptestController.refresh();
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      controller.pagingController.refresh();
                      controller.grouptestController.refresh();
                      return Future.value();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "   All Tests",
                          style: TextStyle(
                            fontSize: 16.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: PagedListView<int, Test>(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            pagingController: controller.pagingController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            builderDelegate: PagedChildBuilderDelegate<Test>(
                              itemBuilder: (context, item, index) {
                                return ListTile(
                                  contentPadding: const EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  dense: T,
                                  title: Text(
                                    "${item.name ?? ""} (₹ ${item.price})",
                                    style: TextStyle(fontSize: 16.h),
                                  ),

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
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 15.0),

                        const Divider(),

                        Text(
                          "   Gorups of Tests",
                          style: TextStyle(
                            fontSize: 18.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Expanded(
                          child: PagedListView<int, Group>(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),

                            pagingController: controller.grouptestController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            builderDelegate: PagedChildBuilderDelegate<Group>(
                              itemBuilder: (context, item, index) {
                                return ListTile(
                                  contentPadding: const EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  dense: T,
                                  title: Text(
                                    "${item.name ?? ""} (₹ ${item.price})",
                                    style: TextStyle(fontSize: 16.h),
                                  ),

                                  trailing: Checkbox(
                                    value: controller.selectedGroupTests.any(
                                      (element) => element.id == item.id,
                                    ),
                                    onChanged: (value) {
                                      controller.toggleGroupSelection(item);
                                    },
                                  ),
                                  onTap: () {
                                    controller.toggleGroupSelection(item);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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
    },
  ).whenComplete(() {});
}
