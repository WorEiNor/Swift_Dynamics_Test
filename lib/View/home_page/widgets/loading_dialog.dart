import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static String get name => 'LoadingDialog';

  static void show(
    BuildContext context, {
    bool canDismiss = false,
  }) async {
    return showDialog(
      barrierDismissible: canDismiss,
      context: context,
      routeSettings: RouteSettings(name: name),
      builder: (context) {
        return const LoadingDialog();
      },
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
