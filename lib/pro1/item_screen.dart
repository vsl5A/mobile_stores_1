import 'package:flutter/material.dart';
import 'package:testtwo/pro1/add_note.dart';
import 'package:testtwo/pro1/update_note.dart';
import 'package:testtwo/pro1/sql_helper.dart';


import 'package:testtwo/test/test3.dart';


import '../test/confirmation_dialog.dart';
import 'item.dart';
import 'login_page.dart';
class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    //String username = ModalRoute.of(context)?.settings.arguments as String;
    //print("in ra giá trị truyên tu test ${ModalRoute.of(context)?.settings.arguments}");
    return  MaterialApp(
      home: _HomePage(email: email),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({super.key, required this.email});
  final String email;

  @override
  State<_HomePage> createState() => _HomePageState(email: email);
}

class _HomePageState extends State<_HomePage> {
  // All items
  List<Map<String, dynamic>> _items = [];

  bool check = true;
  final String email;
  bool _isLoading = true;
  _HomePageState({required this.email});


  // This function is used to fetch all data from the database
  Future<void> _refreshItems() async {
    final data = await SQLHelper.getItems();

    setState(() {
      _items = data;
      _isLoading = false;
    });
    print('show data $_items');
  }

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Loading the diary when the app starts
  }

  final TextEditingController _titleController = TextEditingController();


  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _editItem(Map<String, dynamic>? item) async {
    if (item != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      // final existingItem = _items.firstWhere((element) => element['id'] == id);
      //_titleController.text = existingItem['title'];
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateNote(
                email:email
            ),
            //settings: RouteSettings(arguments: values)),
            settings: RouteSettings(arguments:item)),
      );
      //print('in ra phần tử được chon $id');
    } else {
      print('làm ơn xin chọn lại');

    }


  }

  // Insert a new item to the database


  // Update an existing item


  // Delete an item
  Future<void> _deleteItem(int id) async {
    showConfirmationDialog(
        context: context,
        title: 'Confirm',
        content: 'Do you want to delete?',
        onConfirm: () async {
          await SQLHelper.deleteItem(id);
          // if you're not sure your widget is mounted.
          if (!mounted) return;
          // await SQLHelper.deleteItem(id);

// if you're not sure your widget is mounted.


          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully deleted a item!'),
          ));

          _refreshItems();
        });}

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortedItems = List.from(_items);
    sortedItems.sort((a, b) => a['name'].compareTo(b['name']));
    print('show data đã xếp $sortedItems');
    return Scaffold(
      appBar: AppBar(
        title:  Text('Persist data with $email'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              setState(() {
                if(check ) {
                  check = false;
                } else {
                  check =true;
                }
              });
            },
          ),
          TextButton(
            onPressed: _logout,
            child: Text('user $email'),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(_items,email),
              );
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          :(
          (
      check
      ) ? (ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) => Card(
              color: Colors.orange[200],
              margin: const EdgeInsets.all(15),
              child: ListTile(
                  title: Text(_items[index]['name']),
                  //subtitle: Text(_items[index]['description']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editItem(_items[index]),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(_items[index]['id']),
                        ),
                      ],
                    ),
                  )),
            ),
          )) :
          (ListView.builder(
            itemCount: sortedItems.length,
            itemBuilder: (context, index) => Card(
              color: Colors.orange[200],
              margin: const EdgeInsets.all(15),
              child: ListTile(
                  title: Text(sortedItems[index]['name']),

                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editItem(sortedItems[index]),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(sortedItems[index]['id']),
                        ),
                      ],
                    ),
                  )),
            ),
          )
          )
      )

      ,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        //onPressed: () => _showForm(null),
        onPressed: _add,
      ),
    );
  }

  void _logout() {

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        // Thay LoginScreen bằng màn hình đăng nhập của bạn
            (Route<dynamic> route) => false,
      );


  }
  void _add() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyWidget(
              email:email
          )

      ),
    );
  }
}