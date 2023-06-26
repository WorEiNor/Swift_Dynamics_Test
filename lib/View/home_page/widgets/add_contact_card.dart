import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'add_contact_info_bottom_sheet.dart';

class AddContactCard extends StatelessWidget {
  const AddContactCard({super.key, required this.onSuccess});
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        clipBehavior: Clip.none,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AddContactInfoBottomSheet(onAdd: onSuccess);
        },
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(
              FontAwesomeIcons.plus,
              size: 16,
            ),
            Container(width: 8),
            const Text(
              'Add Contact',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
