import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item.dart';
import 'item_screen.dart';
import 'sql_helper.dart';

class UpdateNote extends StatefulWidget
{
  const UpdateNote({super.key, required this.email});
  final String email;

  @override
  _UpdateNoteState createState() => _UpdateNoteState(email:email);
}

class _UpdateNoteState extends State<UpdateNote>
{
  List<String> valuesCity = [];
  List<String> valuesUniversities = [];
  List<String> valuesScenicSpot = [];
  List<String> valuesSpecialties = [];
  List<String> valuesLicensePlate = [];


  final String email;
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerUniversities = TextEditingController();
  TextEditingController controllerScenicSpot = TextEditingController();
  TextEditingController controllerSpecialties = TextEditingController();
  TextEditingController controllerLicensePlate = TextEditingController();

  final TextEditingController _titleController = TextEditingController();
  bool isShowBuildCity = false;

  bool isShowListCity = false;
  bool isShowBuildUniversities = false;

  bool isShowListUniversities = false;
  bool isShowBuildScenicSpot = false;

  bool isShowListScenicSpot = false;
  bool isShowBuildSpecialties = false;

  bool isShowListSpecialties = false;
  bool isShowBuildLicensePlate = false;

  bool isShowListLicensePlate = false;
  int  check = 1;
  _UpdateNoteState({required this.email});
  void addValueCity()
  {
    setState(() {
      valuesCity.add(controllerCity.text);
      controllerCity.clear();
    });
  }
  void addValueUniversities()
  {
    setState(() {
      valuesUniversities.add(controllerUniversities.text);
      controllerUniversities.clear();
    });
  }
  void addValueScenicSpot()
  {
    setState(() {
      valuesScenicSpot.add(controllerScenicSpot.text);
      controllerScenicSpot.clear();
    });
  }
  void addValueSpecialties()
  {
    setState(() {
      valuesSpecialties.add(controllerSpecialties.text);
      controllerSpecialties.clear();
    });
  }
  void addValueLicensePlate()
  {
    setState(() {
      valuesLicensePlate.add(controllerLicensePlate.text);
      controllerLicensePlate.clear();
    });
  }
  void removeValueCity(int index)
  {
    setState(() {
      valuesCity.removeAt(index);
    });
  }
  void removeValueUniversities(int index)
  {
    setState(() {
      valuesUniversities.removeAt(index);
    });
  }
  void removeValueScenicSpot(int index)
  {
    setState(() {
      valuesScenicSpot.removeAt(index);
    });
  }
  void removeValueSpecialties(int index)
  {
    setState(() {
      valuesSpecialties.removeAt(index);
    });
  }
  void removeValueLicensePlate(int index)
  {
    setState(() {
      valuesLicensePlate.removeAt(index);
    });
  }

  Widget buildInputField(TextEditingController controller, String labelText) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText, // Use the provided labelText parameter here
        ),
      ),
    );
  }
  Widget buildElevatedButton(Function() onPressedFunction) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: onPressedFunction,
        child: const Text('Add'),
      ),
    );
  }
  Widget buildList(List<String> controller,Function(int) onPressedFunction){
    return Expanded( // ListView.builder vẫn giữ nguyên
      child: ListView.builder(
        itemCount: controller.length,
        itemBuilder: (context, index) {

          return Dismissible(
            key: Key(controller[index]),
            child: ListTile(
              title: Text(controller[index]),
              trailing: GestureDetector(
                onTap: () {
                  onPressedFunction(index);
                },
                child: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildBox(String text){
    return SizedBox(
        width: 300, // Chiều rộng cố định
        height: 50, // Chiều cao cố định
        child: Container(
          color: Colors.orange,
          alignment: Alignment.center,
          child:  Text(
              text
          ),
        )
      //Text('abc', style: TextStyle(color: Colors.orange)),
    );
  }
  void toggleStateCity () {
    setState(() {
      isShowBuildCity = !isShowBuildCity;
    });
  }
  void toggleStateUniversities () {
    setState(() {
      isShowBuildUniversities = !isShowBuildUniversities;
    });
  }
  void toggleStateScenicSpot () {
    setState(() {
      isShowBuildScenicSpot = !isShowBuildScenicSpot;
    });
  }
  void toggleStateSpecialties () {
    setState(() {
      isShowBuildSpecialties = !isShowBuildSpecialties;
    });
  }
  void toggleStateLicensePlate () {
    setState(() {
      isShowBuildLicensePlate = !isShowBuildLicensePlate;
    });
  }

  void toggleStateListCity() {
    setState(() {
      isShowListCity = !isShowListCity;
    });
  }
  void toggleStateListUniversities() {
    setState(() {
      isShowListUniversities = !isShowListUniversities;
    });
  }
  void toggleStateListScenicSpot() {
    setState(() {
      isShowListScenicSpot = !isShowListScenicSpot;
    });
  }
  void toggleStateListSpecialties() {
    setState(() {
      isShowListSpecialties = !isShowListSpecialties;
    });
  }
  void toggleStateListLicensePlate() {
    setState(() {
      isShowListLicensePlate = !isShowListLicensePlate;
    });
  }
  Future<void> _updateItem(int id) async {

    final String listOfCity = valuesCity.join('-');
    final String listOfUniversities = valuesUniversities.join('-');
    final String listOfScenicSpot = valuesScenicSpot.join('-');
    final String listOfSpecialties = valuesSpecialties.join('-');
    final String listOfLicensePlate = valuesLicensePlate.join('-');

    await SQLHelper.updateItem(Item(
        id: id,
        name: _titleController.text,
        listOfCity:listOfCity,
        listOfUniversities:listOfUniversities,
        listOfScenicSpot:listOfScenicSpot,
        listOfSpecialties:listOfSpecialties,
        listOfLicensePlate:listOfLicensePlate
      //, content: []
    ));

    //_refreshItems();
  }
  List<Widget> buildSectionWidgets(TextEditingController controller,
      String text,Function() addValue,
      Function() toggleStateList,bool isShowList,List<String> values,
      Function(int) removeValue) {
    return [
      Row(
        children: [
          buildInputField(controller, text),
          buildElevatedButton(addValue),

        ],
      ),
      buildBox(text),
      Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: ElevatedButton(
          onPressed: () {
            toggleStateList();
          },
          child: (isShowList ? const Text('Hide list') : const Text('Show list')),
        ),
      ),

      (isShowList ? (buildList(values, removeValue)) :SizedBox()),
    ];
  }
  @override
  Widget build(BuildContext context)
  {
    Map<String, dynamic> convertitems = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if(check == 1) {
      _titleController.text =convertitems['name'];
      valuesCity =convertitems['listOfCity'].split('-');
      valuesUniversities =convertitems['listOfUniversities'].split('-');
      valuesScenicSpot =convertitems['listOfScenicSpot'].split('-');
      valuesSpecialties =convertitems['listOfSpecialties'].split('-');
      valuesLicensePlate =convertitems['listOfLicensePlate'].split('-');
      check =0; // để chỉ chạy 1 lần duy nhất dù có setstate cũng ko chạy vào nữa
    }
    List<Widget> multipleSections =[
      TextFormField(
        controller: _titleController,
        decoration: InputDecoration(

          labelText:  'Name',
        ),
        textInputAction: TextInputAction.next,
      ), //name
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: ElevatedButton(
          onPressed: () {
            toggleStateCity();
          },
          child: (isShowBuildCity ? const Text('Hide city') :
          const Text('Show city')),
        ),
      ),


    ];
    if(isShowBuildCity) {
      multipleSections.addAll(buildSectionWidgets(controllerCity,
          'List of city',addValueCity,toggleStateListCity,isShowListCity,
          valuesCity,removeValueCity));
    }
    multipleSections.add(Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {
          toggleStateUniversities();
        },
        child: (isShowBuildUniversities ? const Text('Hide Universities') :
        const Text('Show Universities')),
      ),
    ));
    if(isShowBuildUniversities) {
      multipleSections.addAll(buildSectionWidgets(controllerUniversities,
          'List of Universities',addValueUniversities,toggleStateListUniversities,isShowListUniversities,
          valuesUniversities,removeValueUniversities));
    }
    multipleSections.add(Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {
          toggleStateScenicSpot();
        },
        child: (isShowBuildScenicSpot ? const Text('Hide ScenicSpot') :
        const Text('Show ScenicSpot')),
      ),
    ));
    if(isShowBuildScenicSpot) {
      multipleSections.addAll(buildSectionWidgets(controllerScenicSpot,
          'List of ScenicSpot',addValueScenicSpot,toggleStateListScenicSpot,isShowListScenicSpot,
          valuesScenicSpot,removeValueScenicSpot));
    }
    multipleSections.add(Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {
          toggleStateSpecialties();
        },
        child: (isShowBuildSpecialties ? const Text('Hide Specialties') :
        const Text('Show Specialties')),
      ),
    ));
    if(isShowBuildSpecialties) {
      multipleSections.addAll(buildSectionWidgets(controllerSpecialties,
          'List of Specialties',addValueSpecialties,toggleStateListSpecialties,isShowListSpecialties,
          valuesSpecialties,removeValueSpecialties));
    }
    multipleSections.add(Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {
          toggleStateLicensePlate();
        },
        child: (isShowBuildLicensePlate ? const Text('Hide LicensePlate') :
        const Text('Show LicensePlate')),
      ),
    ));
    if(isShowBuildLicensePlate) {
      multipleSections.addAll(buildSectionWidgets(controllerLicensePlate,
          'List of LicensePlate',addValueLicensePlate,toggleStateListLicensePlate,isShowListLicensePlate,
          valuesLicensePlate,removeValueLicensePlate));
    }

    return Scaffold(
      appBar : AppBar(
        title : Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('My note Creates'),
            ),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                _updateItem(convertitems['id']);
                // Xử lý quay trở lại trang chủ
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemsScreen(
                          email:email
                      ),
                      //settings: RouteSettings(arguments: values)),
                      settings: RouteSettings(arguments:{'email': email,
                        'name': _titleController.text})),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.blue,),
      body :

      Column(
        children: multipleSections,
      ),





    );
  }
}

