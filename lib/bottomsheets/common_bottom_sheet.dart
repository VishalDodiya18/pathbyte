import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Common paginated list bottom sheet
class PaginatedSelectionSheet<T> extends StatelessWidget {
  final String title;
  final PagingController<int, T> controller;
  final String Function(T item) itemLabel;
  final void Function(T item) onSelect;
  final T? selectedItem;

  const PaginatedSelectionSheet({
    super.key,
    required this.title,
    required this.controller,
    required this.itemLabel,
    required this.onSelect,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.9,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Select $title",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: PagedListView.separated(
                    separatorBuilder: (_, __) => const Divider(height: 0.5),
                    pagingController: controller,
                    builderDelegate: PagedChildBuilderDelegate<T>(
                      itemBuilder: (context, item, index) {
                        final isSelected = selectedItem == item;
                        return ListTile(
                          title: Text(
                            itemLabel(item),
                            style: TextStyle(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          onTap: () {
                            onSelect(item);
                            // Get.back();
                          },
                        );
                      },
                      firstPageProgressIndicatorBuilder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      newPageProgressIndicatorBuilder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      noItemsFoundIndicatorBuilder: (_) =>
                          const Center(child: Text("No items found")),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
