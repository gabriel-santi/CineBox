import 'package:cinebox/ui/core/themes/colors.dart';
import 'package:cinebox/ui/core/themes/resource.dart';
import 'package:cinebox/ui/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

class SignInGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  const SignInGoogleButton({super.key, required this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Visibility(
              visible: !isLoading,
              replacement: Padding(
                padding: EdgeInsetsGeometry.only(left: 10),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 1,
                  ),
                ),
              ),
              child: SizedBox(
                child: Image.asset(R.ASSETS_IMAGES_GOOGLE_LOGO_PNG),
              ),
            ),
          ),
          Text(
            !isLoading ? "Entrar com Google" : "Realizando Login...",
            style: AppTextStyles.regularSmall.copyWith(color: AppColors.darkGrey),
          ),
        ],
      ),
    );
  }
}
