import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import '../Constants/constants.dart';
import '../cubit/cubit_couter.dart';
import '../models/Product.dart';







class ProductList extends StatefulWidget {
  const ProductList({super.key
  });

  @override
  State<ProductList> createState() => _HomePageState();
}

class _HomePageState extends State<ProductList> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }


  Widget buildProductList(BuildContext context) {
    TextStyle myStyle = const TextStyle(
      fontSize: 37.0,
      fontWeight: FontWeight.bold,
      //color: Colors.blue,
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text('Products ',
              style: myStyle,
            ),
            const Text('All available products in our stores '),
          ],
        ),
        backgroundColor: const Color.fromARGB(255,
            238,
            238,
            238),
        toolbarHeight: 96.0,
      ),
      body:
      RefreshIndicator(
        onRefresh: _refreshProducts,
        child:
        FutureBuilder(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Retrieve Failed ${snapshot.error
              }');
            } else if (snapshot.hasData) {
              final List<Product> products = snapshot.data!;
              //print(' check $products.length');
              return
                Column(children: [
                  Expanded(child: ListView.builder(
                      itemCount: products.length,

                      itemBuilder: (context, index) {
                        final product = products[index
                        ];
                        if(product.quantity != null && product.quantity! > 100) {
                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.grey, width: 2),
                            ),
                            child:




                            Column(

                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Image.network('${products[index
                                ].image
                                }'),
                                // Thay thế bằng đường dẫn hình ảnh của bạn
                                Container(
                                    color: Colors.white,
                                    child:Padding(
                                      padding: const EdgeInsets.all(16.0),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${products[index
                                            ].name
                                            }',
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text('\$${products[index
                                          ].price
                                          } USD'),
                                          const SizedBox(height: 4),
                                          Text('${products[index
                                          ].quantity
                                          } units in stock'),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [

                                              Expanded(
                                                child: ElevatedButton.icon(
                                                  onPressed: () {
                                                    //print('show token login ${context.read<CartCubit>().state['token']}');
                                                    context.read<CartCubit>().setIsDetailProduct(true);
                                                    context.read<CartCubit>().setIdDetailProduct(index);
                                                  },
                                                  icon: const Icon(Icons.info), // thêm icon vào nút
                                                  label: const Text('Details'), // văn bản của nút
                                                  style: ElevatedButton.styleFrom(
                                                    foregroundColor: Colors.white,
                                                    backgroundColor: Colors.blue,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5), // Độ cong của góc
                                                    ), // thiết lập màu văn bản trên nút
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: ElevatedButton.icon(
                                                  onPressed: ()  {

                                                    context.read<CartCubit>().addItem(products[index
                                                    ]);
                                                    //provider.addItem(products[index]);
                                                  },
                                                  icon: const Icon(Icons.shopping_cart), // thêm icon vào nút
                                                  label: const Text('Order Now'), // văn bản của nút
                                                  style: ElevatedButton.styleFrom(
                                                    foregroundColor: Colors.white,
                                                    backgroundColor: Colors.orange,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5), // Độ cong của góc
                                                    ), // thiết lập màu văn bản trên nút
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),

                          );
                        }
                        else {
                          return Container();
                        }
                      }

                  ))
                ],);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      // Container(
      //   constraints: BoxConstraints(),
      //   child: Card(
      //     elevation: 5,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //       side: BorderSide(color: Colors.grey, width: 10),
      //     ),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //
      //       children: [
      //         Image.asset('images/pavlova.jpg'),
      //         // Thay thế bằng đường dẫn hình ảnh của bạn
      //         Padding(
      //           padding: const EdgeInsets.all(16.0),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Text(
      //                 'P201 Pro 128GB Dual SIM Twilight',
      //                 style: TextStyle(
      //                   fontSize: 24,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //               SizedBox(height: 8),
      //               Text('\$899 USD'),
      //               SizedBox(height: 4),
      //               Text('600 units in stock'),
      //               SizedBox(height: 16),
      //               Row(
      //                 children: [
      //                   Expanded(
      //                     child: ElevatedButton(
      //                       onPressed: () {},
      //                       child: Text('Details'),
      //                     ),
      //                   ),
      //                   SizedBox(width: 8),
      //                   Expanded(
      //                     child: ElevatedButton(
      //                       onPressed: () {},
      //                       child: Text('Order Now'),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // )

    );
  }
  Widget buildDetailProduct(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Products ',
            style: TextStyle(
              fontSize: 37.0,
              fontWeight: FontWeight.bold,
              //color: Colors.blue,
            ),),
          backgroundColor: const Color.fromARGB(255,
              238,
              238,
              238),
          toolbarHeight: 72.0,
        ),
        body: FutureBuilder(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Retrieve Failed ${snapshot.error
                }');
              } else  {
                final List<Product> products = snapshot.data!;
                final Product product = products[context.read<CartCubit>().state['idDetailProduct'
                ]
                ];
                return SingleChildScrollView (
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network('${product.image
                          }'),
                          Padding(padding: const EdgeInsets.only(bottom: 1.0),
                            child: Text('${product.name
                            }',
                                style: const TextStyle(
                                  fontSize: 29.0,
                                  fontWeight: FontWeight.bold,
                                  //color: Colors.blue,
                                )
                            ),),
                          const SizedBox(height: 16),
                          Text('${product.description}',
                            style: const TextStyle(
                                fontSize: 16.0
                            ),),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text('Item Code: ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700
                                ),),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            // Thay đổi màu nền theo ý muốn
                            borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text('${product.id}',style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        color: Colors.white
                      )
                      ),
                    ),


                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text('Manufacturer: ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700
                                ),),
                              Text('${product.manufacturer}',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  //color: Colors.white,
                                  //backgroundColor: Color.fromARGB(255, 240, 173, 78)
                                ),),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text('Category: ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700
                                ),),
                              Text('${product.category
                              }',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  //color: Colors.white,
                                  //backgroundColor: Color.fromARGB(255, 240, 173, 78)
                                ),),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text('Available units in stock: ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700
                                ),),
                              Text('${product.quantity
                              }',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  //color: Colors.white,
                                  //backgroundColor: Color.fromARGB(255, 240, 173, 78)
                                ),),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text('Price: ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700
                                ),),
                              Text('${product.price
                              } USD',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  //color: Colors.white,
                                  //backgroundColor: Color.fromARGB(255, 240, 173, 78)
                                ),),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [

                              Expanded(
                                flex: 3,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    context.read<CartCubit>().setIsDetailProduct(false);
                                  },
                                  icon: const Icon(Icons.arrow_back), // thêm icon vào nút
                                  label: const Text('Back'), // văn bản của nút
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5), // Độ cong của góc
                                    ), // thiết lập màu văn bản trên nút
                                  ),
                                ),
                              ),
                              const Expanded(flex: 1,child: Text(''),),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 3,
                                child: ElevatedButton.icon(
                                  onPressed: () {


                                    context.read<CartCubit>().addItem(product);
                                  },
                                  icon: const Icon(Icons.shopping_cart), // thêm icon vào nút
                                  label: const Text('Order Now'), // văn bản của nút
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5), // Độ cong của góc
                                    ), // thiết lập màu văn bản trên nút
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],

                      ),
                    ));
              }
            })
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, Map<String, dynamic>>(
        builder: (context, state) {
          bool isDetailProduct = state['isDetailProduct'
          ] ?? false;
          if (!isDetailProduct) {
            return buildProductList(context);
          }
          else {
            return buildDetailProduct(context);
          }
        }
    );
  }



  List<Product> _parseProducts(List<int> response) {
    // Parse the JSON response
    //final List<dynamic> jsonResponse = json.decode(response);

    final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response));

    // final List<Product> products = jsonResponse["content"]
    //     .map<Product>((json) => Product.fromJson(json))
    //     .toList();
    setState(() {
      List<dynamic> content = jsonResponse[
      "content"
      ];
      for (var item in content) {
        if (item is Map<String, dynamic>) {
          if (!item.containsKey("Qty") || item[
          "Qty"
          ] == null) {
            item[
            "Qty"
            ] = 1; // Nếu thuộc tính "Qty" không tồn tại hoặc null, gán giá trị mặc định là 1
          }
        }
      }
    });
    //Provider.of<ProductProvider>(context, listen: false).setProducts(products);

    print('in ra ds sản pham $jsonResponse');



    return jsonResponse[
    "content"
    ].map<Product>((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> fetchProducts() async {
    // Define the base URL

    final baseUrl = Uri.parse('${Constants.baseUrl}/products');
    final response = await http.get(baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-16',
        });

    if (response.statusCode == 200) {

      return _parseProducts(response.bodyBytes);
    }

    throw Exception('Failed to load Product');
  }
  Future<List<dynamic>> _parseCarts(String response, String token) async{
    // Parse the JSON response


    final List<dynamic> jsonResponse = json.decode(response);
    //final listCart = jsonResponse.map<Cart>((json) => Cart.fromJson(json)).toList();
    final listCart = jsonResponse;


    //print('check list cart  jsonResponse ${jsonResponse}');
    //print('check list cart jsonResponse ${jsonResponse[0]['id']}');
    final List<dynamic> res = [];

    for (int i = 0; i < listCart.length; i++) {

      try {
        final responses = await http.get(
          Uri.parse('http: //10.0.2.2:8080/api/v2/orders/detail/${listCart[i]['id']}'),
          headers: {
            'Authorization': 'Bearer $token',
            // Các header khác nếu cần
          },
        );
        //print('check list responses detail order ${responses.body}');

        final Map<String, dynamic> jsonResponseSub = json.decode(responses.body);
        //print('check list responses detail order decode ${jsonResponseSub}');

        Map<String, dynamic> newMap = {
          "orderId": jsonResponseSub[
          "orderId"
          ],
          "details": jsonResponseSub[
          "details"
          ],
        };
        res.add(newMap);
      } catch (e) {
        print('Có lỗi xảy ra: $e'); // In ra thông báo lỗi
      }
    }
    //print('check list order sự kiện nút nhấn $res');
    //final listOrder = res.map<Order>((json) => Order.fromJson(json)).toList();

    return res;
  }


  Future<List<dynamic>> fetchCarts(String token) async {
    final url = Uri.parse('http: //10.0.2.2:8080/api/v2/orders'); // Thay thế bằng URL thực tế

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Thêm token vào header
        // Các header khác nếu cần
      },
    );

    if (response.statusCode == 200) {

      return _parseCarts(response.body,token);
    }
    throw Exception('Failed to load Orders');
  }
  Future<void> _refreshProducts() async {
    final result = fetchProducts();
    setState(() {
      futureProducts = result;
    });
  }
//   Future<void> _addTrainee({required Todo trainee}) async {
//     final body = {
//       'title': trainee.title,
//       'description': trainee.description,
//
//     };
//
//     final response = await http.post(Uri.parse('https://60db1a79801dcb0017290e61.mockapi.io/todos'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(body));
//
//     if (response.statusCode == 201) {
//
//       var snackBar = const SnackBar(content: Text('Created successfully'));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//     } else {
//
//       var snackBar = SnackBar(content: Text('Error: ${response.statusCode}'));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//     }
// }
}