import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icthub_new_repo/data/data_models/product_data_model.dart';

class ProductsDataSource {
  /// this variable is used to check if the data is loading or not
  static bool isLoading = true;

  /// this variable is used to check if an error occured or not
  static bool isError = false;

  /// this variable is used to store the error message
  static String errorMessage = '';

  /// this list is used to store the data of the products
  static List<ProductDataModel> myList = [];

  // static Future<bool> getProductsData() async {
  //   //https://fakestoreapi.com/products url for task
  //   /// first: we will make a get request to the api
  //   /// with this url 'https://dummyjson.com/products'
  //   /// to get the json data of the products
  //   var response = await http.get(Uri.parse('https://dummyjson.com/products'));
  //
  //   /// second: we will check if the response status code is 200
  //   /// that means the request is successful and we can get the data
  //   if (response.statusCode == 200) {
  //     try {
  //       ///if the response status code is 200 and we have the data
  //       ///first: we will decode the response body from json to map
  //       Map<String, dynamic> data = jsonDecode(response.body);
  //
  //       ///second: we will get the list of products from the data map
  //       List<dynamic> productsList = data['products'];
  //
  //       ///third: we will loop through the products list
  //       for (Map<String, dynamic> item in productsList) {
  //         /// in each item we will create a new ProductDataModel object from the map
  //         ProductDataModel p = ProductDataModel.fromMapJson(item);
  //
  //         /// then we will add the object to the myList
  //         myList.add(p);
  //       }
  //
  //       /// finally: we will set the isLoading to false
  //       /// to stop the loading indicator and show the data
  //
  //       isLoading = false;
  //       return true;
  //     } catch (e) {
  //       /// if an error occured we will catch it and print it
  //       print('error $e');
  //
  //       /// if an error occured we will set the isError to true to show the error message
  //       /// and set the isLoading to false to stop the loading indicator
  //       /// and set the errorMessage to the error message to show it to the user
  //
  //       isLoading = false;
  //       isError = true;
  //       errorMessage = e.toString();
  //       return false;
  //     }
  //   }
  //
  //   /// third: if the response status code is not 200
  //   /// that means an error occured and we will print the error
  //   else {
  //     print('error${response.statusCode}');
  //     print('error${response.body}');
  //
  //     /// if an error occured we will set the isError to true to show the error message
  //     isLoading = false;
  //
  //     /// and set the errorMessage to the error message to show it to the user
  //     isError = true;
  //
  //     /// and set the errorMessage to the error message to show it to the user
  //     errorMessage = '${response.statusCode}\n${response.body} ';
  //     return false;
  //   }
  // }

  static Future<bool> getProductsData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();

      final productsList = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      ///third: we will loop through the products list
      for (Map<String, dynamic> item in productsList) {
        /// in each item we will create a new ProductDataModel object from the map
        ProductDataModel p = ProductDataModel.fromMapJson(item);

        /// then we will add the object to the myList
        myList.add(p);
      }

      /// finally: we will set the isLoading to false
      /// to stop the loading indicator and show the data

      isLoading = false;
      return true;
    } catch (e) {
      /// if an error occured we will catch it and print it
      print('error $e');

      /// if an error occured we will set the isError to true to show the error message
      /// and set the isLoading to false to stop the loading indicator
      /// and set the errorMessage to the error message to show it to the user

      isLoading = false;
      isError = true;
      errorMessage = e.toString();
      return false;
    }
  }
}
