import 'package:flutter/material.dart';
import 'package:icthub_new_repo/data/data_sourec/products_data_source.dart';
import 'package:icthub_new_repo/ui/widgets/error_widget.dart';
import 'package:icthub_new_repo/ui/widgets/loading_widget.dart';
import 'package:icthub_new_repo/ui/widgets/product_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// we use the initState to call the getProductsData function when the screen is build
  /// to get the data of the products from getProductData function
  @override
  void initState() {
    super.initState();
    if (ProductsDataSource.myList.isEmpty) {
      ProductsDataSource.getProductsData().then((value) {
        setState(() {});
        if (value) {
          print('data is retrieved successfully');
        } else {
          print('errorrrrrrrrrrrrrrrrrrrrrrr');
        }
      });
    } else {
      print('data is already retrieved');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// if the isLoading is true we will show a loading indicator
      body: ProductsDataSource.isLoading
          ? const LoadingWidget()
          : ProductsDataSource.isError
              ? MyErrorWidget(
                  errorMsg: ProductsDataSource.errorMessage,
                )
              : ListView.builder(
                  itemCount: ProductsDataSource.myList.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      index: index,
                    );
                  },
                ),
    );
  }
}
