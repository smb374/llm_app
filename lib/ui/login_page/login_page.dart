import 'package:flutter/material.dart';
import 'package:llm_app/ui/login_page/components/login.dart';
import 'package:llm_app/ui/login_page/components/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SegmentedButton(
            segments: const [
              ButtonSegment(value: true, label: Text('Login')),
              ButtonSegment(value: false, label: Text('Register')),
            ],
            selected: {_isLogin},
            onSelectionChanged: (v) => setState(() => _isLogin = v.first),
          ),
          _isLogin ? const LoginContent() : const RegisterContent(),
        ],
      ),
    );
  }
}
