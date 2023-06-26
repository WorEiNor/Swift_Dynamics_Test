import 'package:employee_view/Model/province_model/province_model.dart';
import 'package:employee_view/View/home_page/widgets/loading_dialog.dart';

import 'package:employee_view/View/home_page/widgets/province_search_selector_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../Controller/user_controller.dart';
import '../../../Model/user_model/user_model.dart';

class AddContactInfoBottomSheet extends StatefulWidget {
  const AddContactInfoBottomSheet({super.key, required this.onAdd});

  final VoidCallback onAdd;

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onAdd,
  }) async {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddContactInfoBottomSheet(onAdd: onAdd),
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  State<AddContactInfoBottomSheet> createState() =>
      _AddContactInfoBottomSheetState();
}

class _AddContactInfoBottomSheetState extends State<AddContactInfoBottomSheet> {
  String firstName = '';
  String lastName = '';
  String phoneNo = '';
  String idCardNo = '';
  String address = '';
  ProvinceModel province = ProvinceModel();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.fromLTRB(8, 32, 8, 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stepper(
            currentStep: _index,
            onStepCancel: () {
              if (_index > 0) {
                setState(() {
                  _index -= 1;
                });
              }
              if (_index == 0) {
                AddContactInfoBottomSheet.close(context);
              }
            },
            onStepContinue: () async {
              if (_index <= 0) {
                setState(() {
                  _index += 1;
                });
              }
              if (_index == 1 &&
                  firstName.isNotEmpty &&
                  lastName.isNotEmpty &&
                  phoneNo.isNotEmpty &&
                  idCardNo.isNotEmpty &&
                  address.isNotEmpty &&
                  province.id != null) {
                LoadingDialog.show(context);
                await UserController()
                    .postUser(
                  UserModel(
                    id: Uuid().v4(),
                    firstName: firstName,
                    lastName: lastName,
                    phoneNo: phoneNo,
                    idCardNo: idCardNo,
                    address: address,
                    province: province.nameTh,
                    provinceId: province.id,
                  ),
                )
                    .then(
                  (value) {
                    LoadingDialog.close(context);
                    widget.onAdd();
                    AddContactInfoBottomSheet.close(context);
                  },
                );
              }
            },
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            steps: <Step>[
              Step(
                title: const Text('Step 1 Persoal Information'),
                content: Container(
                    alignment: Alignment.centerLeft,
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
                            hintText: 'Firstname',
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
                            hintText: 'Lastname',
                          ),
                        ),
                        Container(height: 8),
                        Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) => phoneNo = value,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                            hintText: 'Phone Number',
                          ),
                        ),
                        Container(height: 8),
                        Text(
                          'Id Card Number',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) => idCardNo = value,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                            hintText: 'Id Card Number',
                          ),
                        ),
                      ],
                    )),
              ),
              Step(
                title: Text('Step 2 Address'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(height: 8),
                    TextField(
                      onChanged: (value) => address = value,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        hintText: 'Address',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
