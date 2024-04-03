import 'package:flutter/material.dart';
import 'package:customer_info_share/person_list_tab_view.dart';
import 'package:customer_info_share/organization_list_tab_view.dart';

class CustomerInfoListPage extends StatefulWidget {
  CustomerInfoListPage({super.key});


  @override
  CustomerInfoListPageState createState() => CustomerInfoListPageState();
}

class CustomerInfoListPageState extends State<CustomerInfoListPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          //title: const Text('一覧ページ'),
          bottom: const TabBar(
            tabs: <Widget> [ 
              Tab(
                text: '企業',
              ),
              Tab(
                text: '個人',
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            OrganizationListTabView(),
            PersonListTabView(),
          ],
        ),
      ),
    );
  }
}
    