import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:customer_info_share/organization.dart';
import 'package:customer_info_share/helper.dart';

class OrganizationListTabView extends StatefulWidget {
  const OrganizationListTabView({super.key});

  @override
  OrganizationListTabViewState createState() => OrganizationListTabViewState();
}

class OrganizationListTabViewState extends State<OrganizationListTabView> {
  
  List<InitialGroupedOrganizations> groupedOrganizationsList = [];

  void initGroupedOrganizationsList() {
    for (final initial in initialGroupMap.keys) {
      debugPrint('initial: $initial');
      groupedOrganizationsList.add(InitialGroupedOrganizations(initial));
    }
  }

  Future<void> getOrganizations() async {
    final ref = FirebaseDatabase.instance.ref();
    debugPrint('getOrganizations');
    await ref.child('organizations').get().then((data) {
      setState(() {
        for (var c in data.children) {
          debugPrint('${c.value}');
          pushOrganizationToInitialedGroup(groupedOrganizationsList, Organization(c.value as Map<dynamic, dynamic>));
        }
        for (final go in groupedOrganizationsList) {
          go.organizations.sort((a, b) => a.phonetic.compareTo(b.phonetic));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initGroupedOrganizationsList();
    getOrganizations();
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tablist = [];
    for (final e in groupedOrganizationsList) {
      debugPrint('in build: ${e.initial}');
      tablist.add(Tab(text: 'neko'));
    }
    return DefaultTabController(
      length: groupedOrganizationsList.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
            child: AppBar(
              bottom: TabBar(
              indicatorColor: Colors.black,
            tabs: 
              groupedOrganizationsList.map((e) => Text(e.initial)).toList(),
              /*
              Tab(text: 'あ'),
              Tab(text: 'か'),
              Tab(text: 'さ'),
              Tab(text: 'た'),
              Tab(text: 'な'),
              Tab(text: 'は'),
              Tab(text: 'ま'),
              Tab(text: 'や'),
              Tab(text: 'や'),
              Tab(text: 'わ'),
              Tab(text: '不明'),
              */
          ),
        )),
        body: TabBarView(
          children: groupedOrganizationsList.map((e) {
            return ListView.builder(
              itemCount: e.organizations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(e.organizations[index].name),
                  trailing: Text(e.organizations[index].phone),
                );
              }
            );
          }).toList(),
        ),
      ),
    );
  }
}  

