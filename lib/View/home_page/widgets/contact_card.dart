import 'package:employee_view/Controller/user_controller.dart';
import 'package:employee_view/Model/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'contact_info_bottom_sheet.dart';
import 'loading_dialog.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({super.key, required this.user, required this.onDelete});

  final UserModel user;
  final VoidCallback onDelete;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ContactInfoBottomSheet.show(context: context, user: widget.user);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const FaIcon(
              FontAwesomeIcons.circleUser,
              color: Colors.blue,
              size: 55,
            ),
            Container(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.user.firstName} ${widget.user.lastName}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Text(
                  widget.user.province!,
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
                Container(height: 16),
                Text(
                  'Tel : ${widget.user.phoneNo}',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
            const Spacer(),
            CupertinoButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Delete'),
                    content: const Text('Confirm to delete this user?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          LoadingDialog.show(context);
                          await UserController()
                              .deleteUser(widget.user.id!)
                              .then((value) {
                            widget.onDelete();
                            LoadingDialog.close(context);
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
              child: const FaIcon(
                FontAwesomeIcons.trashCan,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
