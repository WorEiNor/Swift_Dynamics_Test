import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Controller/province_controller.dart';
import '../../../Model/province_model/province_model.dart';

class ProvinceSearchSelectorBottomSheet extends StatefulWidget {
  const ProvinceSearchSelectorBottomSheet({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final void Function(ProvinceModel) onSelected;

  static Future<void> show({
    required BuildContext context,
    required void Function(ProvinceModel) onSelected,
  }) async {
    showModalBottomSheet(
      context: context,
      builder: (_) => ProvinceSearchSelectorBottomSheet(onSelected: onSelected),
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
    );
  }

  @override
  State<ProvinceSearchSelectorBottomSheet> createState() =>
      _ProvinceSearchSelectorBottomSheetState();
}

class _ProvinceSearchSelectorBottomSheetState
    extends State<ProvinceSearchSelectorBottomSheet> {
  ScrollController scrollController = ScrollController();

  String searchTextFieldInput = '';

  List<ProvinceModel>? provinceList;

  void _getProvince() async {
    final data = await ProvinceController().getProvinceList();

    setState(() {
      provinceList = data;
    });
  }

  @override
  void initState() {
    _getProvince();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget _buildProvinceList(List<ProvinceModel> provinceList, double width) {
    List<ProvinceModel> list = [];
    if (searchTextFieldInput.isNotEmpty) {
      list = provinceList
          .where((element) => element.nameTh!.contains(searchTextFieldInput))
          .toList();
    } else {
      list = provinceList;
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (_, index) => CupertinoButton(
        onPressed: () {
          widget.onSelected(list[index]);
          Navigator.of(context).pop();
        },
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          width: width,
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          child: Text(list[index].nameTh!),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (provinceList != null) {
      return _buildProvinceList(
          provinceList!, MediaQuery.of(context).size.width);
    } else {
      return const Text('Loading...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.95) -
          MediaQuery.of(context).padding.top,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Province search',
                    style: TextStyle(fontSize: 16),
                  ),
                  CupertinoButton(
                    child: const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: TextField(
                onChanged: (input) {
                  setState(() {
                    searchTextFieldInput = input;
                  });
                },
              ),
            ),
            Expanded(
              child: Scrollbar(
                controller: scrollController,
                child: Center(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: _buildContent(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
