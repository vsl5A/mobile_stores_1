import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pro1/item.dart';
import '../pro1/item_screen.dart';
import '../pro1/update_note.dart';
import '../pro1/sql_helper.dart';
class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> items;
  final String email;
  CustomSearchDelegate(this.items, this.email);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchResults = items.where((item) => item['name'].toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index]['name']),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? items
        : items.where((item) => item['name'].toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]['name']),
          // onTap: () {
          //   // query = suggestionList[index];
          //   // showResults(context);
          //   print('chọn từ tiìm kiếm ${suggestionList[index]}');
          //   print('chọn từ tiìm kiếm check null ${email}');
          // }
          onTap: ()=>{
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdateNote(
                      email:email
                  ),
                  //settings: RouteSettings(arguments: values)),
                  settings: RouteSettings(arguments:suggestionList[index])),
            ),
          } ,
        );
      },
    );
  }
}


