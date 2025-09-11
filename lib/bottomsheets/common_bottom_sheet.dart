import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:labapp/utils/app_color.dart';
import 'package:labapp/utils/app_config.dart';

/// Common paginated list bottom sheet with search + persistent selection
class PaginatedSelectionSheet<T> extends StatefulWidget {
  final String title;
  final PagingController<int, T> controller;
  final String Function(T item) itemLabel;
  final void Function(T item) onSelect;

  /// id extractor (must be unique like item.id)
  final String Function(T item) itemId;
  TextInputType? keyboardType;
  final T? selectedItem;
  final TextEditingController? searchController;
  final List<TextInputFormatter>? inputFormatters;
  Widget? shownwidget;
  PaginatedSelectionSheet({
    super.key,
    required this.title,
    required this.controller,
    required this.itemLabel,
    required this.onSelect,
    required this.itemId,
    this.selectedItem,
    this.searchController,
    this.keyboardType,
    this.inputFormatters,
    this.shownwidget,
  });

  @override
  State<PaginatedSelectionSheet<T>> createState() =>
      _PaginatedSelectionSheetState<T>();
}

class _PaginatedSelectionSheetState<T>
    extends State<PaginatedSelectionSheet<T>> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedId; // <-- selected item by ID

  @override
  void initState() {
    super.initState();
    if (widget.selectedItem != null) {
      _selectedId = widget.itemId(widget.selectedItem as T);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    EasyDebounce.debounce(
      'search-debounce',
      const Duration(milliseconds: 500),
      () {
        widget.controller.refresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
                        "Select ${widget.title}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(Icons.clear),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: widget.searchController,
                  decoration: InputDecoration(
                    hintText: "Search ${widget.title}",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.keyboardType,
                  onChanged: _onSearchChanged,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: PagedListView.separated(
                    separatorBuilder: (_, __) => const Divider(height: 0.5),
                    pagingController: widget.controller,
                    builderDelegate: PagedChildBuilderDelegate<T>(
                      itemBuilder: (context, item, index) {
                        final id = widget.itemId(item);
                        final isSelected = id == _selectedId;

                        return ListTile(
                          tileColor: isSelected
                              ? Theme.of(context).primaryColor
                              : null,
                          title:
                              widget.shownwidget ??
                              Text(
                                widget.itemLabel(item),
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: AppColor.whitecolor,
                                )
                              : null,
                          onTap: () {
                            setState(() {
                              _selectedId = id; // <-- persist by id
                            });
                            widget.onSelect(item);
                          },
                        );
                      },
                      firstPageProgressIndicatorBuilder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      newPageProgressIndicatorBuilder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      noItemsFoundIndicatorBuilder: (_) =>
                          Center(child: Image.asset(AppImage.nodatafound)),
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
