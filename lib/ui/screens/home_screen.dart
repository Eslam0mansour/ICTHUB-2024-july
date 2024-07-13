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
  bool isLoading = true;
  bool isError = false;
  String errorMessage = '';
  List<ProductDataModel> myList = [];

  Future<void> getProductsData() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = jsonDecode(response.body);

        List<dynamic> productsList = data['products'];

        for (Map<String, dynamic> item in productsList) {
          ProductDataModel p = ProductDataModel.fromMapJson(item);
          myList.add(p);
        }

        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print('error $e');
        setState(() {
          isLoading = false;
          isError = true;
          errorMessage = e.toString();
        });
      }
    } else {
      print('error${response.statusCode}');
      print('error${response.body}');
      setState(() {
        isLoading = false;
        isError = true;
        errorMessage = '${response.statusCode}\n${response.body} ';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
