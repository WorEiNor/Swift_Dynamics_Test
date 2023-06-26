import 'package:employee_view/Model/user_model/user_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactInfoBottomSheet extends StatelessWidget {
  const ContactInfoBottomSheet({super.key, required this.user});

  final UserModel user;

  static Future<void> show({
    required BuildContext context,
    required UserModel user,
  }) async {
    showModalBottomSheet(
      context: context,
      builder: (_) => ContactInfoBottomSheet(user: user),
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

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
                'Firstname : ${user.firstName}',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
              Text(
                'Lastname : ${user.lastName}',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
              Text(
                'Phone Number : ${user.phoneNo}',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
              Text(
                'Id Card Number : ${user.phoneNo}',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
              Text(
                'Province : ${user.province}',
                style: TextStyle(fontSize: 16),
              ),
              Container(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
