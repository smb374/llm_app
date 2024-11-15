import 'package:easy_formz_inputs/easy_formz_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/utils.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  EmailInput _email = const EmailInput.pure();
  PasswordInput _password = const PasswordInput.pure();
  bool _inProgress = false;
  bool _isObscure = true;

  _LoginContentState();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, GeneralState<UserState>>(
      listener: (context, state) {
        if (state is RequestFailed<UserState, Login>) {
          setState(() {
            _inProgress = false;
          });
          generalAlert(context, 'Login Failed', state.error);
        } else if (state is RequestInProgress<UserState, Login>) {
          setState(() {
            _inProgress = true;
          });
        } else {
          setState(() {
            _inProgress = false;
          });
        }
      },
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              helperText: _email.isPure
                  ? null
                  : _email.error == EmailValidationError.empty
                      ? 'Please enter your email'
                      : _email.error == EmailValidationError.invalid
                          ? 'Invalid email'
                          : null,
              helperStyle: const TextStyle(color: Colors.redAccent),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() {
                _email = EmailInput.dirty(value: value);
              });
            },
          ),
          TextField(
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: 'Password',
              helperText: _password.isPure
                  ? null
                  : _password.error == PasswordValidationError.empty
                      ? 'Please enter your password'
                      : null,
              helperStyle: const TextStyle(color: Colors.redAccent),
              suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() {
                _password = PasswordInput.dirty(value: value);
              });
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              if (_email.isValid &&
                  _password.error != PasswordValidationError.empty) {
                BlocProvider.of<UserBloc>(context)
                    .add(Login(_email.value, _password.value));
              }
            },
            child: _inProgress
                ? const SizedBox(
                    height: 16.0,
                    width: 16.0,
                    child: CircularProgressIndicator(),
                  )
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
