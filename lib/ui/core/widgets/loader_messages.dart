import 'package:cinebox/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin LoaderAndMessage<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  var isOpen = false;

  void showLoader() {
    if (!isOpen) {
      isOpen = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 60);
        },
      );
    }
  }

  void hideLoader() {
    if (isOpen) {
      isOpen = false;
      Navigator.pop(context);
    }
  }

  void showErrorSnackbar(String message) {
    _showSnackbar(message, AppColors.redColor);
  }

  void showSuccessSnackbar(String message) {
    _showSnackbar(message, Colors.green);
  }

  void showInfoSnackbar(String message) {
    _showSnackbar(message, Colors.lightBlue);
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
