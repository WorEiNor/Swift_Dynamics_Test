import 'package:employee_view/Controller/user_controller.dart';

import 'package:employee_view/View/home_page/widgets/add_contact_card.dart';
import 'package:employee_view/View/home_page/widgets/contact_card.dart';
import 'package:employee_view/View/home_page/widgets/province_search_selector_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userController = UserController();
  int provinceId = 0;
  // List<UserModel>? users = usersList;
  // void fetchUsers() async {
  //   final data = await userController.getUserList();

  //   setState(() {
  //     users = data;
  //   });
  // }

  @override
  void initState() {
    // fetchUsers();
    super.initState();
  }

  Widget _buildContent(int? id) {
    var temp = usersList.toList();
    if (usersList.isEmpty) {
      return Container();
    }
    if (id != null) {
      temp.removeWhere((element) => element.provinceId != id);
    }
    return Column(
      children: [
        ...List.generate(temp.length, (index) {
          final _item = temp[index];
          return ContactCard(
            key: ValueKey('${temp.length}$index'),
            user: _item,
            onDelete: () {
              setState(() {});
            },
          );
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Personal Information Storage'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'All Contact',
                  icon: FaIcon(FontAwesomeIcons.solidUser),
                ),
                Tab(
                  text: 'Sort by Province',
                  icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16),
                    AddContactCard(
                      onSuccess: () {
                        setState(() {});
                      },
                    ),
                    Container(height: 16),
                    _buildContent(null),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16),
                    GestureDetector(
                      onTap: () => ProvinceSearchSelectorBottomSheet.show(
                          context: context,
                          onSelected: (province) {
                            provinceId = province.id!;
                            setState(() {});
                          }),
                      child: Container(
                        child: Text('Select Province'),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    AddContactCard(
                      onSuccess: () {
                        setState(() {});
                      },
                    ),
                    Container(height: 16),
                    _buildContent(provinceId),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
