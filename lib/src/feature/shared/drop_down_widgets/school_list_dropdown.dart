import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/shared/common_api/school_list_api/models/school_list_model.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors/color_constants.dart';
import '../../../core/constants/widgets/text_widgets.dart';

class DropDownSchoolListWidget extends StatefulWidget {
  final SchoolListModel dataModel;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onChangedUrl;
  const DropDownSchoolListWidget(
      {super.key, required this.dataModel, required this.onChanged, required this.onChangedUrl});

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
    return SizedBox(
      height: 40,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: const Row(
            children: [
              // Icon(Icons.home_work_rounded, size: 20),
              // Gap(10),
              TextWidget(
                text: 'Select School',
                tColor: KColor.subText,
              )
            ],
          ),
          items: widget.dataModel.data!
              .map((item) => DropdownMenuItem(
                  value: item.label,
                  child: TextWidget(
                    text: item.label!,
                  )))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String?;
              // print(selectedValue);
            });
            // Find the corresponding Datum object
            SchoolData selectedDatum = widget.dataModel.data!.firstWhere(
                (datum) => datum.label == value,
                orElse: () => SchoolData(id: "0", label: ''));

            // Print the ID if found
            // print('Selected ID: ${selectedDatum.id}');
            // Call the onChanged callback with the selected ID as a string
            if (widget.onChanged != null) {
              widget.onChanged!('${selectedDatum.id}');
            }
            if (widget.onChangedUrl != null) {
              widget.onChangedUrl!('${selectedDatum.baseUrl}');
            }
          },
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: KColor.filledColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          dropdownStyleData:
              const DropdownStyleData(maxHeight: 500, width: 350),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          // dropdownSearchData: DropdownSearchData(
          //   searchController: textEditingController,
          //   searchInnerWidgetHeight: 50,
          //   searchInnerWidget: Container(
          //     height: 50,
          //     padding: const EdgeInsets.only(
          //       top: 8,
          //       bottom: 4,
          //       right: 8,
          //       left: 8,
          //     ),
          //     child: TextFormField(
          //       expands: true,
          //       maxLines: null,
          //       controller: textEditingController,
          //       decoration: InputDecoration(
          //         isDense: true,
          //         contentPadding: const EdgeInsets.symmetric(
          //           horizontal: 10,
          //           vertical: 8,
          //         ),
          //         hintText: 'Search School',
          //         hintStyle: const TextStyle(fontSize: 12),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //       ),
          //     ),
          //   ),
          //   searchMatchFn: (item, searchValue) {
          //     return item.value
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchValue.toLowerCase());
          //   },
          // ),
          selectedItemBuilder: (context) {
            return widget.dataModel.data!.map(
              (item) {
                return Row(
                  children: [
                    Flexible(
                        child: TextWidget(
                      text: selectedValue ?? 'Select School',
                      overflow: TextOverflow.clip,
                    )),
                  ],
                );
              },
            ).toList();
          },
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ),
    );
  }
}
