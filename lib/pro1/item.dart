
class Item {
  final int? id;
  final String? name;
  //final String? description;
  final String? createdAt;
  final String? listOfCity;
  final String? listOfUniversities;
  final String? listOfScenicSpot;
  final String? listOfSpecialties;
  final String? listOfLicensePlate;


  //Uint8List? image;
  Item({
    this.listOfUniversities, this.listOfScenicSpot, this.listOfSpecialties,
      this.id, this.name, this.createdAt, this.listOfCity,
    this.listOfLicensePlate
   });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,

      'listOfCity':listOfCity,
      'listOfUniversities':listOfUniversities,
      'listOfScenicSpot':listOfScenicSpot,
      'listOfSpecialties':listOfSpecialties,
      'listOfLicensePlate':listOfLicensePlate
      //'image':image
    };
  }
}