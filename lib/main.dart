import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/ui/login_page/login_page.dart';
import 'package:llm_app/ui/drawer/drawer.dart';
import 'package:llm_app/ui/search_page/search_page.dart';
import 'package:llm_app/ui/session_page/session_page.dart';
import 'package:llm_app/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => SessionBloc()),
          BlocProvider(create: (_) => ChatBloc()),
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => SearchBloc()),
        ],
        child: MaterialApp(
          title: 'LLM App Example',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'LLM App Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _token;
  String? _refreshToken;
  User? _profile;
  bool _init = true;
  // bool _startRewind = false;
  UserEvent? _rewindUser;
  SessionEvent? _rewindSession;
  ChatEvent? _rewindChat;

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final sessionBloc = BlocProvider.of<SessionBloc>(context);
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final pageBloc = BlocProvider.of<PageBloc>(context);

    if (_init) {
      pageBloc.add(SwitchLogin());
    }
    _init = false;

    return MultiBlocListener(
      listeners: [
        BlocListener<SessionBloc, GeneralState<SessionState>>(
          // listenWhen: (previous, current) {
          //   return current is TokenExpired<SessionState, SessionEvent>;
          // },
          listener: (context, state) {
            if (state is TokenExpired<SessionState, SessionEvent>) {
              showTokenExpiredSnackbar(context);
              _rewindSession = state.event;
              userBloc.add(Refresh(_refreshToken!));
              sessionBloc.add(SessionReset());
            }
          },
        ),
        BlocListener<ChatBloc, GeneralState<ChatState>>(
          // listenWhen: (previous, current) {
          //   return current is TokenExpired<ChatState, ChatEvent>;
          // },
          listener: (context, state) {
            if (state is TokenExpired<ChatState, ChatEvent>) {
              showTokenExpiredSnackbar(context);
              _rewindChat = state.event;
              userBloc.add(Refresh(_refreshToken!));
              chatBloc.add(ChatReset());
            }
          },
        ),
        BlocListener<UserBloc, GeneralState<UserState>>(
          listener: (context, state) {
            if (state is RequestSuccess<UserState, UserLoginResponse>) {
              setState(() {
                _token = state.resp.token;
                _refreshToken = state.resp.refreshToken;
              });
              userBloc.add(Profile(_token!));
              pageBloc.add(SwitchSession());
            } else if (state is RequestSuccess<UserState, User>) {
              setState(() {
                _profile = state.resp;
              });
            } else if (state is TokenExpired<UserState, Refresh>) {
              userBloc.add(LoginAgain());
            } else if (state is TokenExpired<UserState, UserEvent>) {
              showTokenExpiredSnackbar(context);
              _rewindUser = state.event;
              userBloc.add(Refresh(_refreshToken!));
            } else if (state is UserLoginAgain) {
              setState(() {
                _token = null;
                _refreshToken = null;
              });
              generalAlert(context, 'Login Again',
                  'Your refresh token has expired, please login again.');
              pageBloc.add(SwitchLogin());
            } else if (state is UserLogout) {
              setState(() {
                _token = null;
                _refreshToken = null;
              });
              pageBloc.add(SwitchLogin());
            } else if (state is UserTokenRefreshed) {
              setState(() {
                _token = state.token;
              });
              if (_rewindUser != null) {
                userBloc.add(UserRewind(state.token, _rewindUser!));
                _rewindUser = null;
              }
              if (_rewindSession != null) {
                sessionBloc.add(SessionRewind(state.token, _rewindSession!));
                _rewindUser = null;
              }
              if (_rewindChat != null) {
                chatBloc.add(ChatRewind(state.token, _rewindChat!));
                _rewindChat = null;
              }
              showTokenRefreshedSnackbar(context);
              // } else if (state is UserNeedRefresh) {
              //   userBloc.add(Refresh(_refreshToken!));
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LLM Test App'),
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        drawer: (_profile != null && _token != null)
            ? MainDrawer(_token!, _profile!)
            : null,
        body: BlocBuilder<PageBloc, PageState>(
          builder: (context, state) {
            switch (state) {
              case PageState.login:
                return const LoginPage();
              case PageState.session:
                return SessionPage(
                  token: _token!,
                );
              case PageState.search:
                return SearchPage(token: _token);
              default:
                return const Placeholder();
            }
          },
        ),
        floatingActionButton:
            BlocBuilder<PageBloc, PageState>(builder: (context, state) {
          switch (state) {
            case PageState.session:
              return FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<SessionBloc>(context)
                      .add(SessionCreate(_token!));
                },
                tooltip: 'Create session',
                child: const Icon(Icons.add),
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  const Placeholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is a placeholder.'),
    );
  }
}
