import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class LoadingIndicator {
  static void showLoading(BuildContext context, {String? loadingMessage}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator.adaptive(),
                ),
                Hspace(18),
                Flexible(
                  child: Text(
                    loadingMessage ?? "Please wait...",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
    );
  }

  static void removeLoading(BuildContext context) {
    context.pop();
  }
}
