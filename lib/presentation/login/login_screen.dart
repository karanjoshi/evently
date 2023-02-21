import 'package:evently/presentation/add_event/add_event_screen.dart';
import 'package:evently/theme/colors.dart';
import 'package:evently/theme/decorations.dart';
import 'package:flutter/material.dart';

import '../../theme/fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 204,
                  height: 111,
                  child: Center(
                    child: Text(
                      "Evently",
                      style: AppFonts.logoText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              decoration: AppDecorations.appBgShadow,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "Plan, Invite, and\nManage events\nlike a pro.",
                        style: AppFonts.regular32,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, bottom: 85),
                    child: InkWell(
                      child: const _SignInWithGoogleButton(),
                      onTap: () => _onTapSignInWithGoogle(context),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _onTapSignInWithGoogle(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AddEventScreen();
      }),
    );
  }
}

class _SignInWithGoogleButton extends StatelessWidget {
  const _SignInWithGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 313,
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            "assets/icons/google.png",
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 36,
          ),
          Center(
            child: Text(
              "Continue with Google",
              style: AppFonts.regular18
                  .copyWith(color: AppColors.textColorSecondary),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
