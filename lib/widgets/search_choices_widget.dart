import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class SearchChoicesWidget extends StatefulWidget {
  final List<DropdownMenuItem<Object>>? items;
  final Object? selectedValue;
  final Function? onChanged;
  final String title;
  final bool readOnly;
  const SearchChoicesWidget(
      {Key? key,
      required this.items,
      required this.selectedValue,
      required this.title,
      required this.onChanged,
      this.readOnly = false})
      : super(key: key);

  @override
  State<SearchChoicesWidget> createState() => _SearchChoicesWidgetState();
}

class _SearchChoicesWidgetState extends State<SearchChoicesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF858C94),
        ),
      ),
      child: SearchChoices.single(
        padding: EdgeInsets.zero,
        readOnly: widget.readOnly,
        items: widget.items,
        value: widget.selectedValue,
        hint: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF09101D),
            ),
          ),
        ),
        searchHint: "Tìm kiếm",
        onChanged: widget.onChanged,
        isExpanded: true,
        closeButton: "Đóng",
        displayClearIcon: false,
        iconEnabledColor: const Color(0xFF09101D),
        iconSize: 24.0,
        underline: Container(
          height: 0,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide.none),
          ),
        ),
        searchFn: (String keyword, items) {
          List<int> ret = [];
          if (items != null && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              items.forEach((item) {
                if (k.isNotEmpty &&
                    (removeDiacritics(item.value.name)
                        .toString()
                        .toLowerCase()
                        .contains(removeDiacritics(k).toLowerCase()))) {
                  ret.add(i);
                }
                i++;
              });
            });
          }
          if (keyword.isEmpty) {
            ret = Iterable<int>.generate(items.length).toList();
          }
          return (ret);
        },
      ),
    );
  }
}
