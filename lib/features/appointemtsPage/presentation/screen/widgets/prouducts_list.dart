import 'package:flutter/material.dart';
import '../../../../appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/product_item.dart';

class productGridView extends StatelessWidget {
  const productGridView({
    super.key,
    required this.count,
    required this.product,
  });

  final int count;
  final List<Product> product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          return ProductItem(
            product: product[index],
          );
        },
      ),
    );
  }
}
