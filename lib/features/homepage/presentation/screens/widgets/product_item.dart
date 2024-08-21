import 'package:team_app/core/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:team_app/core/utils/size_config.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/deatiles_product.dart';

import '../../../../appointemtsPage/data/models/apointement_model.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: 150,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                "http://${AppConstants.ip}:8000/${product.image}", // Ensure the image URL is accessible
                height: SizeConfig.screenHeight * .2,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      color: AppConstants.orangeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price} ل.س',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        'الكمية  ${product.pivot.amount}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "التصنيف",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        product.categoryId == 1
                            ? "ألواح "
                            : product.categoryId == 2
                                ? "بطاريات"
                                : "انفيرتر",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    product.disc,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppConstants.orangeColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
