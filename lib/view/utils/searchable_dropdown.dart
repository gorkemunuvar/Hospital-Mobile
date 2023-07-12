import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchableDropdown<T> extends StatelessWidget {
  final List<T> items;
  final Function itemAsString;
  final T selectedItem;
  final Function onChanged;
  final bool enabled;

  SearchableDropdown(
    this.items,
    this.itemAsString, {
    this.selectedItem,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownSearch<T>(
        items: items,
        selectedItem: selectedItem,
        itemAsString: itemAsString,
        enabled: enabled,
        onChanged: onChanged,
        mode: Mode.MENU,
        showSearchBox: true,
        searchBoxStyle: TextStyle(color: Colors.grey[700]),
        dropdownButtonBuilder: (_) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_drop_down,
            size: 24,
            color: enabled ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
