import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/search.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/ui/search_page/components/result_list_page.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _queryString = TextEditingController();
  DateTime? _dateStart;
  DateTime? _dateEnd;
  final TextEditingController _caseNum1 = TextEditingController();
  final TextEditingController _caseNum2 = TextEditingController();
  final TextEditingController _caseNum3 = TextEditingController();
  final TextEditingController _issue = TextEditingController();
  final TextEditingController _main = TextEditingController();

  _SearchPageState();

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final tagsController = MultiSelectController<ReportTag>();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _queryString,
            decoration: const InputDecoration(
              labelText: '全文檢索',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final result = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2100));
                    setState(() {
                      if (result != null) {
                        _dateStart = result;
                      }
                    });
                  },
                  child: Text(_dateStart == null
                      ? '開始日期'
                      : '${_dateStart!.year}-${_dateStart!.month}-${_dateStart!.day}'),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final result = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2100));
                    setState(() {
                      if (result != null) {
                        _dateEnd = result;
                      }
                    });
                  },
                  child: Text(_dateEnd == null
                      ? '結束日期'
                      : '${_dateEnd!.year}-${_dateEnd!.month}-${_dateEnd!.day}'),
                ),
              ),
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
            ),
          ),
          TextField(
            controller: _main,
            decoration: const InputDecoration(
              labelText: '主文',
              border: OutlineInputBorder(),
            ),
          ),
          MultiDropdown<ReportTag>(
            controller: tagsController,
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
              DropdownItem(label: ReportTag.tagEC.name, value: ReportTag.tagEC),
              DropdownItem(label: ReportTag.tagHI.name, value: ReportTag.tagHI),
              DropdownItem(label: ReportTag.tagLP.name, value: ReportTag.tagLP),
              DropdownItem(label: ReportTag.tagIP.name, value: ReportTag.tagIP),
              DropdownItem(label: ReportTag.tagCI.name, value: ReportTag.tagCI),
              DropdownItem(label: ReportTag.tagBD.name, value: ReportTag.tagBD),
              DropdownItem(label: ReportTag.tagMD.name, value: ReportTag.tagMD),
              DropdownItem(label: ReportTag.tagCD.name, value: ReportTag.tagCD),
              DropdownItem(label: ReportTag.tagNC.name, value: ReportTag.tagNC),
              DropdownItem(label: ReportTag.tagIW.name, value: ReportTag.tagIW),
              DropdownItem(label: ReportTag.tagID.name, value: ReportTag.tagID),
              DropdownItem(label: ReportTag.tagTP.name, value: ReportTag.tagTP),
              DropdownItem(label: ReportTag.tagEP.name, value: ReportTag.tagEP),
              DropdownItem(label: ReportTag.tagRD.name, value: ReportTag.tagRD),
              DropdownItem(label: ReportTag.tagEA.name, value: ReportTag.tagEA),
              DropdownItem(label: ReportTag.tagPC.name, value: ReportTag.tagPC),
              DropdownItem(label: ReportTag.tagBC.name, value: ReportTag.tagBC),
              DropdownItem(label: ReportTag.tagFM.name, value: ReportTag.tagFM),
              DropdownItem(label: ReportTag.tagGP.name, value: ReportTag.tagGP),
              DropdownItem(label: ReportTag.tagSA.name, value: ReportTag.tagSA),
              DropdownItem(label: ReportTag.tagFT.name, value: ReportTag.tagFT),
              DropdownItem(label: ReportTag.tagPE.name, value: ReportTag.tagPE),
              DropdownItem(label: ReportTag.tagLA.name, value: ReportTag.tagLA),
              DropdownItem(label: ReportTag.tagPN.name, value: ReportTag.tagPN),
              DropdownItem(label: ReportTag.tagFC.name, value: ReportTag.tagFC),
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
                dateStart: _dateStart != null
                    ? '${_dateStart?.year}-${_dateStart?.month}-${_dateStart?.day}'
                    : null,
                dateEnd: _dateEnd != null
                    ? '${_dateEnd?.year}-${_dateEnd?.month}-${_dateEnd?.day}'
                    : null,
                caseNum: cn.isNotEmpty ? cn : null,
                issue: _issue.text != '' ? _issue.text : null,
                main: _main.text != '' ? _main.text : null,
                tags: tagsController.selectedItems.map((v) => v.value).toSet(),
              );
              searchBloc.add(FullSearch(params));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultListPage(params: params),
                ),
              );
            },
          ),
        ].expand((x) => [const SizedBox(height: 10.0), x]).skip(1).toList(),
      ),
    );
  }
}
