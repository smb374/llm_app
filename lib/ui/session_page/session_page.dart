import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/ui/chat_page/chat_page.dart';
import 'package:llm_app/utils.dart';

class SessionPage extends StatefulWidget {
  final String token;

  const SessionPage({required this.token, super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  // List<Session> _sessions = [];
  final Map<String, Session> _sessionMap = {};
  bool _inProgress = false;
  bool _init = true;

  _SessionPageState();

  @override
  Widget build(BuildContext context) {
    final sessionBloc = BlocProvider.of<SessionBloc>(context);

    if (_init) {
      sessionBloc.add(SessionList(widget.token));
    }
    _init = false;

    final sessions = _sessionMap.values.toList();
    sessions.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return BlocListener<SessionBloc, GeneralState<SessionState>>(
      listener: (context, state) {
        if (state is RequestInProgress<SessionState, SessionList>) {
          setState(() {
            _inProgress = true;
          });
        } else if (state is RequestSuccess<SessionState, SessionListResponse>) {
          setState(() {
            _inProgress = false;
            // _sessions = state.resp.sessions;
            for (final s in state.resp.sessions) {
              if (!_sessionMap.containsKey(s.uuid)) {
                _sessionMap[s.uuid] = s;
              }
            }
          });
        } else if (state
            is RequestSuccess<SessionState, SessionCreateResponse>) {
          final session = state.resp.session;
          setState(() {
            _sessionMap[session.uuid] = session;
          });
        } else if (state
            is RequestSuccess<SessionState, SessionDeleteResponse>) {
          setState(() {
            _sessionMap.remove(state.resp.deletedId);
          });
          // sessionBloc.add(SessionList(widget.token));
        } else if (state is RequestFailed<SessionState, SessionList>) {
          setState(() {
            _inProgress = false;
          });
          generalAlert(context, 'Failed to fetch sessions', state.error);
        } else if (state is RequestFailed<SessionState, SessionCreate>) {
          generalAlert(context, 'Failed to create session', state.error);
        } else if (state is RequestFailed<SessionState, SessionDelete>) {
          generalAlert(context, 'Failed to delete session', state.error);
        } else if (state
            is RequestFailed<SessionState, SessionCreateWithReport>) {
          generalAlert(
              context, 'Failed to create session with report', state.error);
        } else if (state is SessionCaptionUpdate) {
          if (_sessionMap.containsKey(state.sessionId)) {
            setState(() {
              // _tmpCaption = (state.sessionId, state.caption);
              _sessionMap[state.sessionId]!.caption = state.caption;
            });
          }
        }
      },
      child: _inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(5.0),
              children: sessions
                  .map((s) => Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                              sessionBloc
                                  .add(SessionDelete(widget.token, s.uuid));
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          title: s.caption == ''
                              ? const Text('Empty Session')
                              : Text('${s.caption}...'),
                          trailing: const Icon(Icons.arrow_right),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  token: widget.token,
                                  sessionId: s.uuid,
                                ),
                              ),
                            );
                          },
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}
