import 'package:employee_view/Model/user_model/user_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
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
              Align(
                alignment: Alignment.center,
                child: FaIcon(
                  FontAwesomeIcons.circleUser,
                  size: 150,
                ),
              ),
              Container(height: 32),
              RichText(
                text: TextSpan(
                  text: 'Firstname: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${user.firstName}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Lastname: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${user.lastName}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Phone Number: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${user.phoneNo}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Id Card Number: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${user.idCardNo}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Address: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${user.address}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Province: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${user.province}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
