import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindsolver_flutter/components/chat.bubble.dart';
import 'package:mindsolver_flutter/screens/auth/auth_view_model.dart';
import 'package:mindsolver_flutter/screens/main_screen.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

import 'input_profile_screen.dart';

class AuthScreen extends StatelessWidget {
  final AuthViewModel viewModel = AuthViewModel();

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    Text('Mind Solver', style: kTitleTextStyle),
                    SizedBox(height: 8),
                    Text('Your personal diary with AI bot', style: kBody1TextStyle),
                    SizedBox(height: 48),
                    ChatBubble(message: 'How are you feeling today?', isMe: false),
                    SizedBox(height: 8),
                    ChatBubble(message: '😃...good', isMe: true),
                  ],
                ),
              ),
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
                        Text('Sign in with Google', style: kSubtitleTextStyle.copyWith(color: kGrayDarkColor)),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    final result = await viewModel.signInWithGoogle();
                    bool userExists = await viewModel.isUserExists();

                    if (!context.mounted) return;

                    if (result == true) {
                      if (userExists) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
                      } else {
                        final user = await viewModel.getCurrentUser();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InputProfileScreen(
                            userName: user?.displayName ?? '',
                          ),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign in failed.')));
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
