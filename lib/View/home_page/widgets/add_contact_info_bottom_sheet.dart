import 'package:employee_view/Model/province_model/province_model.dart';
import 'package:employee_view/Model/user_model/user_model.dart';

import 'package:employee_view/View/home_page/widgets/province_search_selector_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../Controller/user_controller.dart';

class AddContactInfoBottomSheet extends StatefulWidget {
  const AddContactInfoBottomSheet({super.key, required this.onAdd});

  final VoidCallback onAdd;

  @override
  State<AddContactInfoBottomSheet> createState() =>
      _AddContactInfoBottomSheetState();
}

class _AddContactInfoBottomSheetState extends State<AddContactInfoBottomSheet> {
  String firstName = '';
  String lastName = '';
  String phoneNo = '';
  String idCardNo = '';
  ProvinceModel province = ProvinceModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Firstname',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
              TextField(
                onChanged: (value) => firstName = value,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  labelText: 'Firstname',
                ),
              ),
              Container(height: 8),
              Text(
                'Lastname',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
              TextField(
                onChanged: (value) => lastName = value,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  labelText: 'Lastname',
                ),
              ),
              Container(height: 8),
              Text(
                'Phone Number',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
              TextField(
                onChanged: (value) => phoneNo = value,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
              Container(height: 8),
              Text(
                'Id Card Number',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
              TextField(
                onChanged: (value) => idCardNo = value,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  labelText: 'Id Card Number',
                ),
              ),
              Container(height: 8),
              Text(
                'Province',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
              GestureDetector(
                onTap: () {
                  ProvinceSearchSelectorBottomSheet.show(
                    context: context,
                    onSelected: (value) {
                      setState(() {
                        province = value;
                        print(province.nameTh);
                        print(value.nameTh);
                      });
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 15, 8, 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        province.nameTh ?? 'Province',
                        style: TextStyle(fontSize: 16),
                      ),
                      FaIcon(FontAwesomeIcons.angleDown),
                    ],
                  ),
                ),
              ),
              Container(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: (firstName.isNotEmpty &&
                              lastName.isNotEmpty &&
                              phoneNo.isNotEmpty &&
                              phoneNo.isNotEmpty &&
                              province.id != null)
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    if (firstName.isNotEmpty &&
                        lastName.isNotEmpty &&
                        phoneNo.isNotEmpty &&
                        phoneNo.isNotEmpty &&
                        province.id != null) {
                      await UserController().postUser(
                        UserModel(
                          id: Uuid().v4(),
                          firstName: firstName,
                          lastName: lastName,
                          phoneNo: phoneNo,
                          idCardNo: idCardNo,
                          province: province.nameTh,
                          provinceId: province.id,
                        ),
                      );
                      widget.onAdd();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
