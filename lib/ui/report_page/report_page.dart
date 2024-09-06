import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/utils.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:llm_app/ui/webview_page/webview_page.dart';

class ReportPage extends StatefulWidget {
  final String caseNum;
  final String issue;
  final String reportId;
  const ReportPage(
      {required this.caseNum,
      required this.issue,
      required this.reportId,
      super.key});

  @override
  State<StatefulWidget> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(GetReport(widget.reportId));
    return BlocBuilder<SearchBloc, GeneralState<SearchState>>(
      builder: (context, state) {
        Widget child = const Text('Unknown State.');
        if (state is RequestInProgress) {
          child = const CircularProgressIndicator();
        } else if (state is RequestSuccess<SearchState, ReportResponse>) {
          final resp = state.resp;
          if (!resp.success) {
            child = const Text('No Data.');
          } else {
            child = Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Html(
                  data: '<div>${resp.response.reportBase.content}</div>',
                  onLinkTap: (url, attributes, element) {
                    if (url != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => WebViewPage(url: url)),
                      );
                    }
                  },
                  style: {
                    'div': Style(
                      whiteSpace: WhiteSpace.pre,
                    ),
                  },
                ),
              ),
            );
          }
        } else if (state is RequestFailed<SearchState, GetReport>) {
          generalAlert(context, 'Get Report Request Failed', state.error);
          child = const Text('No Data.');
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('${widget.caseNum} ${widget.issue}'),
          ),
          body: Center(
            child: child,
          ),
        );
      },
    );
  }
}
