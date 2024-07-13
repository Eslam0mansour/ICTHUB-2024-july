import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icthub_new_repo/data/data_models/product_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// this variable is used to check if the data is loading or not
  bool isLoading = true;

  /// this variable is used to check if an error occured or not
  bool isError = false;

  /// this variable is used to store the error message
  String errorMessage = '';

  /// this list is used to store the data of the products
  List<ProductDataModel> myList = [];

  Future<void> getProductsData() async {
    //https://fakestoreapi.com/products url for task
    /// first: we will make a get request to the api
    /// with this url 'https://dummyjson.com/products'
    /// to get the json data of the products
    var response = await http.get(Uri.parse('https://dummyjson.com/products'));

    /// second: we will check if the response status code is 200
    /// that means the request is successful and we can get the data
    if (response.statusCode == 200) {
      try {
        ///if the response status code is 200 and we have the data
        ///first: we will decode the response body from json to map
        Map<String, dynamic> data = jsonDecode(response.body);

        ///second: we will get the list of products from the data map
        List<dynamic> productsList = data['products'];

        ///third: we will loop through the products list
        for (Map<String, dynamic> item in productsList) {
          /// in each item we will create a new ProductDataModel object from the map
          ProductDataModel p = ProductDataModel.fromMapJson(item);

          /// then we will add the object to the myList
          myList.add(p);
        }

        /// finally: we will set the isLoading to false
        /// to stop the loading indicator and show the data
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        /// if an error occured we will catch it and print it
        print('error $e');

        /// if an error occured we will set the isError to true to show the error message
        /// and set the isLoading to false to stop the loading indicator
        /// and set the errorMessage to the error message to show it to the user

        setState(() {
          isLoading = false;
          isError = true;
          errorMessage = e.toString();
        });
      }
    }

    /// third: if the response status code is not 200
    /// that means an error occured and we will print the error
    else {
      print('error${response.statusCode}');
      print('error${response.body}');
      setState(() {
        /// if an error occured we will set the isError to true to show the error message
        isLoading = false;

        /// and set the errorMessage to the error message to show it to the user
        isError = true;

        /// and set the errorMessage to the error message to show it to the user
        errorMessage = '${response.statusCode}\n${response.body} ';
      });
    }
  }

  /// we use the initState to call the getProductsData function when the screen is build
  /// to get the data of the products from getProductData function
  @override
  void initState() {
    super.initState();
    getProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// if the isLoading is true we will show a loading indicator
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Please wait until data is loaded...'),
                ],
              ),
            )

          ///else if the isError is true we will show an error message
          : isError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50,
                      ),
                      const SizedBox(height: 20),
                      Text('Error occured: $errorMessage'),
                    ],
                  ),
                )

              ///else we will show the data of the products
              /// because the isLoading and isError are false
              : ListView.builder(
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        'name ${myList[index].name ?? 'no data'}',
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        'description ${myList[index].description ?? 'no data'}',
                        maxLines: 2,
                      ),
                      leading: myList[index].imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: myList[index].imageUrl!,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : Image.asset('assets/img.png'),
                      trailing: Text(
                        'price ${myList[index].price ?? 'no data'}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
