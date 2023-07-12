import 'package:flutter/material.dart';

import 'date_button.dart';

typedef OnTapCallback = Function(String value);

class HorizontalListView extends StatefulWidget {
  final List<String> titleList;
  final OnTapCallback onTap;

  HorizontalListView(this.titleList, {this.onTap});

  @override
  _HorizontalListViewState createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  List<bool> isSelectedList;

  @override
  initState() {
    super.initState();
    isSelectedList = List.filled(widget.titleList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          itemCount: widget.titleList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return DateButton(
              title: widget.titleList[index],
              isSelected: isSelectedList[index],
              onPressed: () {
                for (int i = 0; i < isSelectedList.length; i++) {
                  if (index == i)
                    isSelectedList[i] = true;
                  else
                    isSelectedList[i] = false;
                }

                String selectedItem = widget.titleList[index];
                widget.onTap(selectedItem);

                setState(() {});
              },
            );
          },
        ),
      ),
    );
  }
}
