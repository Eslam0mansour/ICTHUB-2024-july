import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icthub_new_repo/data/data_sourec/products_data_source.dart';

class ProductWidget extends StatelessWidget {
  final int index;
  const ProductWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'name ${ProductsDataSource.myList[index].name ?? 'no data'}',
        maxLines: 1,
      ),
      subtitle: Text(
        'description ${ProductsDataSource.myList[index].description ?? 'no data'}',
        maxLines: 2,
      ),
      leading: ProductsDataSource.myList[index].imageUrl != null
          ? CachedNetworkImage(
              imageUrl: ProductsDataSource.myList[index].imageUrl!,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : Image.asset('assets/img.png'),
      trailing: Text(
        'price ${ProductsDataSource.myList[index].price ?? 'no data'}',
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
