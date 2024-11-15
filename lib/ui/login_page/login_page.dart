import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/ui/login_page/components/login.dart';
import 'package:llm_app/ui/login_page/components/register.dart';
import 'package:llm_app/ui/webview_page/webview_page.dart';
import 'package:llm_app/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLogin = true;

  Future<void> oauthButtonHandler(UserBloc userBloc, String provider) async {
    final uri = await Navigator.push<Uri>(
        context,
        MaterialPageRoute(
          builder: (_) => WebViewPage(
            url: 'https://$apiBase/api/auth/$provider',
          ),
        ));
    if (uri != null) {
      if (uri.path.contains('/callback')) {
        final error = uri.queryParameters['error'];
        if (error != null) {
          userBloc.add(UserOauthFailed(error));
        } else {
          final token = uri.queryParameters['token']!;
          final refreshToken = uri.queryParameters['refresh']!;
          userBloc.add(UserOauthSuccess(token, refreshToken));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
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
          const Divider(),
          FilledButton(
            onPressed: () => oauthButtonHandler(userBloc, 'google'),
            child: const Text('Login with Google'),
          ),
          FilledButton(
            onPressed: () => oauthButtonHandler(userBloc, 'facebook'),
            child: const Text('Login with Facebook'),
          ),
        ],
      ),
    );
  }
}
