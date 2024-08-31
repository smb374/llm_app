import 'package:easy_formz_inputs/easy_formz_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/utils.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({super.key});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  NonEmptyInput _name = const NonEmptyInput.pure();
  EmailInput _email = const EmailInput.pure();
  PasswordInput _password = const PasswordInput.pure();
  ConfirmPasswordInput _confirm = const ConfirmPasswordInput.pure();
  bool _inProgress = false;
  bool _isPasswordObscure = true;
  bool _isConfirmObscure = true;

  _RegisterContentState();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, GeneralState<UserState>>(
      listener: (context, state) {
        if (state is RequestFailed<UserState, Register>) {
          setState(() {
            _inProgress = false;
            _name = const NonEmptyInput.pure();
            _email = const EmailInput.pure();
            _password = const PasswordInput.pure();
            _confirm = const ConfirmPasswordInput.pure();
          });
          generalAlert(context, 'Register Failed', state.error);
        } else if (state is RequestInProgress<UserState, Register>) {
          setState(() {
            _inProgress = true;
          });
        } else {
          setState(() {
            _inProgress = false;
            _name = const NonEmptyInput.pure();
            _email = const EmailInput.pure();
            _password = const PasswordInput.pure();
            _confirm = const ConfirmPasswordInput.pure();
          });
        }
      },
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              helperText: _name.isPure
                  ? null
                  : _name.error == NonEmptyValidationError.empty
                      ? 'Please enter your name'
                      : null,
              helperStyle: const TextStyle(color: Colors.redAccent),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() {
                _name = NonEmptyInput.dirty(value: value);
              });
            },
          ),
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
            obscureText: _isPasswordObscure,
            decoration: InputDecoration(
              labelText: 'Password',
              helperText: _password.isPure
                  ? null
                  : _password.error == PasswordValidationError.empty
                      ? 'Please enter your password'
                      : null,
              helperStyle: const TextStyle(color: Colors.redAccent),
              suffixIcon: IconButton(
                icon: Icon(_isPasswordObscure
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isPasswordObscure = !_isPasswordObscure;
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
          TextField(
            obscureText: _isConfirmObscure,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              helperText: _confirm.isPure
                  ? null
                  : _confirm.error == ConfirmPasswordValidationError.empty
                      ? 'Please enter your password again here'
                      : _confirm.error ==
                              ConfirmPasswordValidationError.noCoincidence
                          ? 'Password not match'
                          : null,
              helperStyle: const TextStyle(color: Colors.redAccent),
              suffixIcon: IconButton(
                icon: Icon(_isConfirmObscure
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isConfirmObscure = !_isConfirmObscure;
                  });
                },
              ),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() {
                _confirm = ConfirmPasswordInput.dirty(
                    password: _password.value, value: value);
              });
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              if (_name.isValid &&
                  _email.isValid &&
                  _password.error != PasswordValidationError.empty &&
                  _confirm.isValid) {
                BlocProvider.of<UserBloc>(context)
                    .add(Register(_name.value, _email.value, _password.value));
                // BlocProvider.of<UserBloc>(context)
                //     .add(Login(_email.value, _password.value));
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
