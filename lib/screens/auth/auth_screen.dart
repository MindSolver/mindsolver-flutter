import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindsolver_flutter/screens/auth/auth_view_model.dart';
import 'package:mindsolver_flutter/screens/main_screen.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

class AuthScreen extends StatelessWidget {
  final AuthViewModel viewModel;

  AuthScreen({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.only(bottom: 48),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 2,
                    shadowColor: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('icons/google.svg'),
                        SizedBox(width: 16),
                        Text('Sign in with Google', style: kSubtitleTextStyle.copyWith(color: kgrayDarkColor)),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    await viewModel.signInWithGoogle();
                    final user = await viewModel.getCurrentUser();
                    if (user != null) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
