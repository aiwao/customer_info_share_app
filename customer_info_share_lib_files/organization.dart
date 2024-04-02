import 'package:flutter/material.dart';
import 'package:customer_info_share/helper.dart';

class InitialGroupedOrganizations {
  String initial = '';
  List<Organization> organizations = [];
  
  InitialGroupedOrganizations(this.initial) {
    debugPrint('constructor: $initial');
  }
}

class Organization {
  int no = 0; 
  String id = ''; // 'organization<no>'
  String name = '';
  String phonetic = '';
  String phone = '';
  String address = '';

  Organization(final Map<dynamic, dynamic> src) {
    no = src.containsKey('no') ? src['no'] : 0;
    id = (no != 0) ? 'person$no' : '';
    name = src.containsKey('name') ? src['name'] : '';
    phonetic = src.containsKey('phonetic') ? src['phonetic'] : '';
    phone = src.containsKey('phone') ? src['phone'] : '';
    address = src.containsKey('address') ? src['address'] : '';
  }    
}  

void pushOrganizationToInitialedGroup(List<InitialGroupedOrganizations> groupedOrganizationsList, Organization org) {
  final initial = getInitial(org.phonetic);
  for (final go in groupedOrganizationsList) {
    debugPrint('go: ${go.initial}');
    String? row = initialGroupMap[go.initial];
    for (var i = 0; i < row!.length; ++i) {
      String? c = row.substring(i, i+1);
      if (c == initial) {
        debugPrint('CCC: $c');
        debugPrint('added to Org(${go.initial})');
        go.organizations.add(org);
        break;
      }
    }
    debugPrint('行：$row');
  }
}




    


