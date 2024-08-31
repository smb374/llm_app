import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/search.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/ui/search_page/components/result_list_page.dart';
import 'package:llm_app/utils.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _queryString = TextEditingController();
  final TextEditingController _caseNum1 = TextEditingController();
  final TextEditingController _caseNum2 = TextEditingController();
  final TextEditingController _caseNum3 = TextEditingController();
  final TextEditingController _issue = TextEditingController();
  final TextEditingController _main = TextEditingController();

  final MultiSelectController<ReportTag> _tagsController =
      MultiSelectController();

  final DateSelectController _start = DateSelectController();
  final DateSelectController _end = DateSelectController();

  _SearchPageState();

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _queryString,
                decoration: const InputDecoration(
                  labelText: '全文檢索',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              Row(
                children: [
                  DateSelectButton(controller: _start, labelText: '開始日期'),
                  const SizedBox(width: 10.0),
                  DateSelectButton(controller: _end, labelText: '結束日期'),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _caseNum1,
                      decoration: const InputDecoration(
                        labelText: '年',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _caseNum2,
                      decoration: const InputDecoration(
                        labelText: '字',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _caseNum3,
                      decoration: const InputDecoration(
                        labelText: '號',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _issue,
                decoration: const InputDecoration(
                  labelText: '案由',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              TextField(
                controller: _main,
                decoration: const InputDecoration(
                  labelText: '主文',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              MultiDropdown<ReportTag>(
                controller: _tagsController,
                fieldDecoration: const FieldDecoration(
                  hintText: '分類',
                  borderRadius: 5,
                ),
                dropdownDecoration: DropdownDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  backgroundColor: theme.colorScheme.surfaceContainer,
                  maxHeight: 200,
                ),
                dropdownItemDecoration: DropdownItemDecoration(
                  selectedBackgroundColor: theme.colorScheme.secondaryFixed,
                  disabledBackgroundColor: theme.colorScheme.surfaceDim,
                ),
                items: [
                  DropdownItem(
                      label: ReportTag.tagEC.name, value: ReportTag.tagEC),
                  DropdownItem(
                      label: ReportTag.tagHI.name, value: ReportTag.tagHI),
                  DropdownItem(
                      label: ReportTag.tagLP.name, value: ReportTag.tagLP),
                  DropdownItem(
                      label: ReportTag.tagIP.name, value: ReportTag.tagIP),
                  DropdownItem(
                      label: ReportTag.tagCI.name, value: ReportTag.tagCI),
                  DropdownItem(
                      label: ReportTag.tagBD.name, value: ReportTag.tagBD),
                  DropdownItem(
                      label: ReportTag.tagMD.name, value: ReportTag.tagMD),
                  DropdownItem(
                      label: ReportTag.tagCD.name, value: ReportTag.tagCD),
                  DropdownItem(
                      label: ReportTag.tagNC.name, value: ReportTag.tagNC),
                  DropdownItem(
                      label: ReportTag.tagIW.name, value: ReportTag.tagIW),
                  DropdownItem(
                      label: ReportTag.tagID.name, value: ReportTag.tagID),
                  DropdownItem(
                      label: ReportTag.tagTP.name, value: ReportTag.tagTP),
                  DropdownItem(
                      label: ReportTag.tagEP.name, value: ReportTag.tagEP),
                  DropdownItem(
                      label: ReportTag.tagRD.name, value: ReportTag.tagRD),
                  DropdownItem(
                      label: ReportTag.tagEA.name, value: ReportTag.tagEA),
                  DropdownItem(
                      label: ReportTag.tagPC.name, value: ReportTag.tagPC),
                  DropdownItem(
                      label: ReportTag.tagBC.name, value: ReportTag.tagBC),
                  DropdownItem(
                      label: ReportTag.tagFM.name, value: ReportTag.tagFM),
                  DropdownItem(
                      label: ReportTag.tagGP.name, value: ReportTag.tagGP),
                  DropdownItem(
                      label: ReportTag.tagSA.name, value: ReportTag.tagSA),
                  DropdownItem(
                      label: ReportTag.tagFT.name, value: ReportTag.tagFT),
                  DropdownItem(
                      label: ReportTag.tagPE.name, value: ReportTag.tagPE),
                  DropdownItem(
                      label: ReportTag.tagLA.name, value: ReportTag.tagLA),
                  DropdownItem(
                      label: ReportTag.tagPN.name, value: ReportTag.tagPN),
                  DropdownItem(
                      label: ReportTag.tagFC.name, value: ReportTag.tagFC),
                ],
              ),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  final cn = [_caseNum1, _caseNum2, _caseNum3]
                      .map((x) => x.text)
                      .where((x) => x != '')
                      .toList();
                  final params = SearchParams(
                    querySentence:
                        _queryString.text != '' ? _queryString.text : null,
                    keyword: _queryString.text != '' ? _queryString.text : null,
                    dateStart: _start.date != null
                        ? '${_start.date?.year}-${_start.date?.month}-${_start.date?.day}'
                        : null,
                    dateEnd: _end.date != null
                        ? '${_end.date?.year}-${_end.date?.month}-${_end.date?.day}'
                        : null,
                    caseNum: cn.isNotEmpty ? cn : null,
                    issue: _issue.text != '' ? _issue.text : null,
                    main: _main.text != '' ? _main.text : null,
                    tags: _tagsController.selectedItems
                        .map((v) => v.value)
                        .toSet(),
                  );
                  searchBloc.add(FullSearch(params));
                  Navigator.push<int?>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultListPage(params: params),
                    ),
                  ).then((result) {
                    if (result == 0xdeadbeef) {
                      generalAlert(context, 'No Reports Found',
                          'Your query condition did not match any results.');
                    }
                  });
                },
              ),
            ].expand((x) => [const SizedBox(height: 10.0), x]).skip(1).toList(),
          ),
        ),
      ),
    );
  }
}

class DateSelectController extends ChangeNotifier {
  DateTime? date;
  DateSelectController();

  updateDate(DateTime? newDate) {
    date = newDate;
    notifyListeners();
  }
}

class DateSelectButton extends StatefulWidget {
  final String labelText;
  final DateSelectController? controller;

  const DateSelectButton({required this.labelText, this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _DateSelectButtonState();
}

class _DateSelectButtonState extends State<DateSelectButton> {
  DateTime? _selection;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () async {
          final result = await showDatePicker(
              context: context,
              firstDate: DateTime(1970),
              lastDate: DateTime(2100));
          setState(() {
            if (result != null) {
              _selection = result;
            }
            if (widget.controller != null) {
              widget.controller!.updateDate(result);
            }
          });
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<OutlinedBorder?>(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
        ),
        child: Text(_selection == null
            ? widget.labelText
            : '${_selection!.year}-${_selection!.month}-${_selection!.day}'),
      ),
    );
  }
}
