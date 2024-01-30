import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindsolver_flutter/screens/auth/input_profile_view_model.dart';
import 'package:mindsolver_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class InputProfileImageBox extends StatelessWidget {
  InputProfileImageBox({super.key});

  Future<void> _upload() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InputProfileViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: viewModel.pickImage,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey, // 그레이 컬러 또는 다른 적절한 색상 사용
                ),
                child: ClipOval(
                  child: viewModel.profileUrl.isNotEmpty
                      ? Image.network(
                          viewModel.profileUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : SizedBox(width: 100, height: 100),
                ),
              ),
              if (viewModel.isUploading) CircularProgressIndicator(),
            ],
          ),
        ),
      ],
    );
  }
}
