import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static Future<void> showLoadingDialog({
    required BuildContext context,
    required String loadingMessage,
    required bool barrierDismissible,
  }) {
    Widget content = Row(
      spacing: 8,
      children: [
        Platform.isAndroid
            ? const CircularProgressIndicator()
            : const CupertinoActivityIndicator(),
        Text(loadingMessage),
      ],
    );
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder:
          (context) =>
              Platform.isAndroid
                  ? AlertDialog(content: content)
                  : CupertinoAlertDialog(content: content),
    );
  }

  static Future<void> showInfoDialog({
    required BuildContext context,
    String? title,
    String? message,
    String? posActionTitle,
    String? negActionTitle,
    Function? posAction,
    Function? negAction,
  }) {
    Widget? content = message != null ? Text(message) : null;
    List<Widget> actions = [];
    if (posActionTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (posAction != null) {
              posAction();
            }
          },
          child: Text(posActionTitle),
        ),
      );
    }
    if (negActionTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (negAction != null) {
              negAction();
            }
          },
          child: Text(negActionTitle),
        ),
      );
    }
    return showDialog(
      context: context,
      builder:
          (context) =>
              Platform.isAndroid
                  ? AlertDialog(
                    title: title != null ? Text(title) : null,
                    content: content,
                    actions: actions,
                  )
                  : CupertinoAlertDialog(
                    title: title != null ? Text(title) : null,
                    content: content,
                    actions: actions,
                  ),
    );
  }
}
