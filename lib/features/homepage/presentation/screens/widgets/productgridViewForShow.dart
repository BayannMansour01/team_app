import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/features/appointemtsPage/data/models/allProductResponse.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';
import 'package:team_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_state.dart';

class productGridViewforshow extends StatelessWidget {
  const productGridViewforshow({
    super.key,
    required this.count,
    required this.product,
  });

  final int count;
  final List<Productforshow> product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
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
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Productforshow product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homepageCubit(getIt.get<HomeRepoImpl>()),
      child: BlocConsumer<homepageCubit, homepageState>(
        listener: (context, state) {
          if (state is OrderAmountChanged) {
            log("message");
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<homepageCubit>(context);
          return InkWell(
            onTap: () {
              // Add your onTap functionality here if needed
            },
            child: Container(
              // height: 500,
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
              // width: 30,
              // margin: EdgeInsets.all(7),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        "http://${AppConstants.ip}:8000/${product.image}", // Ensure the image URL is accessible
                        height: 80,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              color: AppConstants.orangeColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 10,
                                  onPressed: () {
                                    cubit.decreaseQuantity(product.id);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                Text(
                                  '${cubit.getQuantity(product.id)}',
                                  style: TextStyle(fontSize: 7),
                                ),
                                IconButton(
                                  iconSize: 10,
                                  onPressed: () {
                                    cubit.increaseQuantity(product.id);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "التصنيف",
                                style: TextStyle(
                                  fontSize: 7,
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
                                  fontSize: 7,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        cubit.addToupdatedProduct(ProductForUpdate(
                            id: product.id,
                            amount: cubit.getQuantity(product.id)));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppConstants.orangeColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              'إضافة ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
