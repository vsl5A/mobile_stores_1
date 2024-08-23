class Product {
   final int? id;
  final String? name;
  final String? description;
  final int ? price;
   final int? quantity;
   final String? manufacturer;
   final String? category;
   final String? condition;
   final String? image;
     int? Qty;




   Product({required this.price, this.quantity, this.manufacturer, this.category,
     this.condition, this.image, this.id, this.name, this.description,this.Qty});

 factory Product.fromJson(Map<String, dynamic> json) {
 return Product(
   id: json['id'], name: json['name'], description: json['description'],
     price: json['price'],quantity: json['quantity'],manufacturer: json['manufacturer'],
   category: json['category'],condition: json['condition'],image: json['image'],
 Qty: json['Qty']);
   }
   }