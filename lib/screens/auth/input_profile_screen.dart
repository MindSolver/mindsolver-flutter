import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/user.dart';
import 'package:mindsolver_flutter/screens/auth/image_picker.dart';
import 'package:mindsolver_flutter/screens/auth/input_profile_view_model.dart';
import 'package:mindsolver_flutter/screens/home/home_screen.dart';
import 'package:mindsolver_flutter/screens/main_screen.dart';
import 'package:mindsolver_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class InputProfileScreen extends StatefulWidget {
  final String userName;

  const InputProfileScreen({super.key, required this.userName});

  @override
  State<InputProfileScreen> createState() => _InputProfileScreenState();
}

class _InputProfileScreenState extends State<InputProfileScreen> {
  final viewModel = InputProfileViewModel();

  late TextEditingController _userNameController;
  final _ageController = TextEditingController();
  final _jobController = TextEditingController();
  int _gender = 0; // 초기값은 남자로 설정

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.userName);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Input your profile', style: kTitleTextStyle),
                  SizedBox(height: 32),
                  InputProfileImageBox(),
                  SizedBox(height: 32),
                  TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _jobController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Job',
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Gender: '),
                      Radio(
                        value: 0,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value as int;
                          });
                        },
                      ),
                      Text('Male'),
                      Radio(
                        value: 1,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value as int;
                          });
                        },
                      ),
                      Text('Female'),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final name = _userNameController.text;
                      final job = _jobController.text;
                      await viewModel.addUser(UserDoc(
                        name: name,
                        job: job,
                        profileUrl: viewModel.profileUrl,
                        age: int.tryParse(_ageController.text) ?? 0,
                        gener: _gender,
                      ));
                      if (!mounted) return;
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 2,
                      shadowColor: Colors.black,
                    ),
                    child: Text('Confirm'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
