import 'dart:math';

import 'package:easy_formz_inputs/easy_formz_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/utils.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

ChatBubble createChatBubble(
    BuildContext context, MessageRole role, Widget child) {
  final colorScheme = Theme.of(context).colorScheme;
  return ChatBubble(
    clipper: role == MessageRole.user
        ? ChatBubbleClipper1(type: BubbleType.sendBubble)
        : ChatBubbleClipper1(type: BubbleType.receiverBubble),
    alignment:
        role == MessageRole.user ? Alignment.topRight : Alignment.topLeft,
    margin: const EdgeInsets.only(top: 10.0),
    backGroundColor: role == MessageRole.user
        ? colorScheme.surfaceDim
        : colorScheme.inversePrimary,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      child: child,
    ),
  );
}

class ChatPage extends StatefulWidget {
  final String token;
  final String sessionId;

  const ChatPage({required this.token, required this.sessionId, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> _messages = [];
  bool _init = true;
  String? _nextMessage;
  bool _enabled = true;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final sessionBloc = BlocProvider.of<SessionBloc>(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (_init) {
      sessionBloc.add(SessionGet(widget.token, widget.sessionId));
    }
    _init = false;

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent));

    return MultiBlocListener(
      listeners: [
        BlocListener<SessionBloc, GeneralState<SessionState>>(
          listener: (context, state) {
            if (state is RequestSuccess<SessionState, SessionGetResponse>) {
              setState(() {
                _messages = state.resp.session.messages;
              });
            } else if (state is RequestFailed<SessionState, SessionGet>) {
              generalAlert(context, 'Failed to fetch session', state.error);
            }
          },
        ),
        BlocListener<ChatBloc, GeneralState<ChatState>>(
            listener: (context, state) {
          if (state is RequestSuccess<ChatState, ProgressResponse>) {
            chatBloc
                .add(ChatProgressConnect(widget.token, state.resp.statusId));
          } else if (state is RequestSuccess<ChatState, Stream<ChatProgress>>) {
            setState(() {
              _nextMessage = '';
            });
            state.resp.forEach((progress) async {
              if (progress.error != "") {
                await generalAlert(context,
                    'Error occurred during chat progress', progress.error!);
              } else if (progress.end) {
                setState(() {
                  _messages.add(Message(MessageRole.assistant, _nextMessage!));
                  _nextMessage = null;
                  _enabled = true;
                });
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              } else {
                var content = progress.data?.message.content;
                if (content != null) {
                  setState(() {
                    _nextMessage = _nextMessage! + content;
                  });
                }
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              }
            });
          } else if (state is RequestFailed<ChatState, ChatRequest>) {
            generalAlert(context, 'Failed to request chat', state.error);
          } else if (state is RequestFailed<ChatState, ChatProgressConnect>) {
            generalAlert(
                context, 'Failed to connect to chat progress', state.error);
          }
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: _messages
                        .where((m) => m.role != MessageRole.system)
                        .map(
                          (m) => createChatBubble(
                            context,
                            m.role,
                            Text(m.content),
                          ),
                        )
                        .toList() +
                    [
                      if (_nextMessage != null)
                        createChatBubble(
                          context,
                          MessageRole.assistant,
                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Text(_nextMessage!),
                              SpinKitWave(
                                color: colorScheme.primary,
                                size: 16.0,
                              ),
                            ],
                          ),
                        )
                    ],
              ),
            ),
            const SizedBox(height: 10.0),
            MessageBar(
              token: widget.token,
              sessionId: widget.sessionId,
              enabled: _enabled,
              onSend: (content) {
                chatBloc
                    .add(ChatRequest(widget.token, widget.sessionId, content));
                if (_messages.isEmpty) {
                  final subLength = min(content.length, 50);
                  sessionBloc.add(UpdateCaption(
                      widget.sessionId, content.substring(0, subLength)));
                }
                setState(() {
                  _messages.add(Message(MessageRole.user, content));
                  _enabled = false;
                });
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBar extends StatefulWidget {
  final String token;
  final String sessionId;
  final bool enabled;
  final void Function(String) onSend;

  const MessageBar(
      {required this.token,
      required this.sessionId,
      required this.onSend,
      this.enabled = true,
      super.key});

  @override
  State<MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<MessageBar> {
  final _sendController = TextEditingController();
  NonEmptyInput _sendInput = const NonEmptyInput.pure();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(color: colorScheme.surfaceContainer),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                enabled: widget.enabled,
                controller: _sendController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Message...',
                ),
                onChanged: (value) => setState(() {
                  _sendInput = NonEmptyInput.dirty(value: value);
                }),
                maxLines: null,
              ),
            ),
            IconButton(
              onPressed: !widget.enabled
                  ? null
                  : () {
                      widget.onSend(_sendInput.value);
                      setState(() {
                        _sendController.clear();
                        _sendInput = const NonEmptyInput.pure();
                      });
                    },
              color: colorScheme.primary,
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
