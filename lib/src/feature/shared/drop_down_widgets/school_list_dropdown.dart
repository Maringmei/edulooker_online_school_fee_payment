import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/shared/common_api/school_list_api/models/school_list_model.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors/color_constants.dart';
import '../../../core/constants/widgets/text_widgets.dart';

class DropDownSchoolListWidget extends StatefulWidget {
  final SchoolListModel dataModel;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onChangedUrl;
  final String? Function(String?)? validator;

  const DropDownSchoolListWidget({
    super.key,
    required this.dataModel,
    required this.onChanged,
    required this.onChangedUrl,
    this.validator,
  });

  @override
  State<DropDownSchoolListWidget> createState() =>
      _DropDownSchoolListWidgetState();
}

class _DropDownSchoolListWidgetState extends State<DropDownSchoolListWidget> {
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: KColor.filledColor,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
      hint: const TextWidget(
        text: 'Select School',
        tColor: KColor.subText,
      ),
      items: widget.dataModel.data!
          .map((item) => DropdownMenuItem(
          value: item.label,
          child: TextWidget(
            text: item.label!,
          )))
          .toList(),
      validator: widget.validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a school';
        }
        return null;
      },
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });

        // Find the corresponding SchoolData object
        if (value != null) {
          SchoolData selectedDatum = widget.dataModel.data!.firstWhere(
                  (datum) => datum.label == value,
              orElse: () => SchoolData(id: "0", label: ''));

          // Call the onChanged callback with the selected ID as a string
          if (widget.onChanged != null) {
            widget.onChanged!('${selectedDatum.id}');
          }
          if (widget.onChangedUrl != null) {
            widget.onChangedUrl!('${selectedDatum.baseUrl}');
          }
        }
      },

      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 500,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        offset: const Offset(0, -5),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
      dropdownSearchData: DropdownSearchData(
        searchController: textEditingController,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: textEditingController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Search School',
              hintStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        searchMatchFn: (item, searchValue) {
          return item.value
              .toString()
              .toLowerCase()
              .contains(searchValue.toLowerCase());
        },
      ),
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          textEditingController.clear();
        }
      },
    );
  }
}