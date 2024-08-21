// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:team_app/core/constants.dart';
// import 'package:team_app/core/utils/service_locator.dart';
// import 'package:team_app/core/utils/size_config.dart';
// import 'package:team_app/features/appointemtsPage/data/models/allProductResponse.dart';
// import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
// import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo_impl.dart';
// import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
// import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
// import 'package:team_app/features/homepage/data/models/products_update_body.dart';
// import 'package:team_app/features/homepage/presentation/screens/widgets/deatiles_product.dart';

// class productGridViewforshow extends StatelessWidget {
//   const productGridViewforshow({
//     super.key,
//     required this.count,
//     required this.product,
//   });

//   final int count;
//   final List<Productforshow> product;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           AppointementsCubit(getIt.get<AppointementsRepoImpl>()),
//       child: Container(
//         height: 500,
//         width: double.maxFinite,
//         child: SingleChildScrollView(
//           child: GridView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: count,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 8.0,
//               mainAxisSpacing: 8.0,
//               childAspectRatio: 0.6,
//             ),
//             itemBuilder: (context, index) {
//               return ProductItem(
//                 product: product[index],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProductItem extends StatelessWidget {
//   final dynamic product;

//   ProductItem({
//     super.key,
//     required this.product,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<AppointementsCubit>();

//     return BlocConsumer<AppointementsCubit, AppointementsState>(
//       listener: (context, state) {
//         if (state is OrderUpdatedState) {
//           log('OrderUpdatedState2222222222  ${state.productsUpdates.length}');
//         }
//       },
//       builder: (context, state) {
//         return InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ProductDetailsPage(product: product),
//               ),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//             ),
//             child: Expanded(
//               child: Column(
//                 children: [
//                   Image.network(
//                     "http://${AppConstants.ip}:8000/${product.image}",
//                     height: SizeConfig.defaultSize * 10,
//                     width: double.infinity,
//                     fit: BoxFit.contain,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Text(
//                       product.name,
//                       style: TextStyle(
//                         color: AppConstants.orangeColor,
//                         fontSize: SizeConfig.defaultSize,
//                         fontWeight: FontWeight.bold,
//                         overflow: TextOverflow.ellipsis, // Overflow handling
//                       ),
//                       maxLines: 1, // Limiting to one line
//                     ),
//                   ),
//                   SizedBox(height: 1),
//                   Text(
//                     '${product.price} ل.س',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: SizeConfig.defaultSize,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 1),
//                   Container(
//                     height: SizeConfig.defaultSize * 4,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             cubit.decreaseQuantity(product.id);
//                           },
//                           icon: Icon(Icons.remove, size: 12),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             '${cubit.getQuantity(product.id)}',
//                             style: TextStyle(fontSize: 10),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             cubit.increaseQuantity(product.id);
//                           },
//                           icon: Icon(Icons.add, size: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 1),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         cubit.addToupdatedProduct(
//                           ProductUpdate(
//                             id: product.id,
//                             amount: cubit.getQuantity(product.id),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: AppConstants.orangeColor,
//                           borderRadius: BorderRadius.vertical(
//                             bottom: Radius.circular(12),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Center(
//                             child: Text(
//                               'إضافة ',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// // class ProductItem extends StatelessWidget {
// //   final Productforshow product;

// //   const ProductItem({
// //     Key? key,
// //     required this.product,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) =>
// //           AppointementsCubit(getIt.get<AppointementsRepoImpl>()),
// //       child: BlocConsumer<AppointementsCubit, AppointementsState>(
// //         listener: (context, state) {
// //           if (state is OrderAmountChanged) {
// //             log("OrderAmountChanged");
// //           }
// //         },
// //         builder: (context, state) {
// //           final cubit = BlocProvider.of<AppointementsCubit>(context);
// //           return InkWell(
// //             onTap: () {
// //               // Add your onTap functionality here if needed
// //             },
// //             child: Container(
// //               // height: 500,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(12),
// //                 color: Colors.white,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.5),
// //                     spreadRadius: 2,
// //                     blurRadius: 5,
// //                     offset: Offset(0, 3), // changes position of shadow
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   Expanded(
// //                     flex: 4,
// //                     child: ClipRRect(
// //                       borderRadius:
// //                           BorderRadius.vertical(top: Radius.circular(12)),
// //                       child: Image.network(
// //                         "http://${AppConstants.ip}:8000/${product.image}", // Ensure the image URL is accessible
// //                         height: 80,
// //                         width: double.infinity,
// //                         fit: BoxFit.contain,
// //                       ),
// //                     ),
// //                   ),
// //                   Expanded(
// //                     // flex: 4,
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Column(
// //                         children: [
// //                           Text(
// //                             product.name,
// //                             style: TextStyle(
// //                               color: AppConstants.orangeColor,
// //                               fontSize: 15,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           Container(
// //                             height: 30,
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 IconButton(
// //                                   iconSize: 10,
// //                                   onPressed: () {
// //                                     cubit.decreaseQuantity(product.id);
// //                                   },
// //                                   icon: Icon(Icons.remove),
// //                                 ),
// //                                 Text(
// //                                   '${cubit.getQuantity(product.id)}',
// //                                   style: TextStyle(fontSize: 7),
// //                                 ),
// //                                 IconButton(
// //                                   iconSize: 10,
// //                                   onPressed: () {
// //                                     cubit.increaseQuantity(product.id);
// //                                   },
// //                                   icon: Icon(Icons.add),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 "التصنيف",
// //                                 style: TextStyle(
// //                                   fontSize: 7,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 product.categoryId == 1
// //                                     ? "ألواح "
// //                                     : product.categoryId == 2
// //                                         ? "بطاريات"
// //                                         : "انفيرتر",
// //                                 style: TextStyle(
// //                                   color: Colors.grey[600],
// //                                   fontSize: 7,
// //                                 ),
// //                                 maxLines: 2,
// //                                 overflow: TextOverflow.ellipsis,
// //                               ),
// //                             ],
// //                           ),
// //                           SizedBox(
// //                             height: 1,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   Expanded(
// //                     flex: 2,
// //                     child: InkWell(
// //                       onTap: () {
// //                         cubit.addToupdatedProduct(
// //                           ProductUpdate(
// //                             id: product.id,
// //                             amount: cubit.getQuantity(product.id),
// //                           ),
// //                         );
// //                       },
// //                       child: Container(
// //                         width: double.infinity,
// //                         decoration: BoxDecoration(
// //                           color: state is OrderUpdatedState
// //                               ? AppConstants.blueColor
// //                               : AppConstants.orangeColor,
// //                           borderRadius: BorderRadius.vertical(
// //                               bottom: Radius.circular(12)),
// //                         ),
// //                         child: Padding(
// //                           padding: const EdgeInsets.symmetric(vertical: 8.0),
// //                           child: Center(
// //                             child: Text(
// //                               'إضافة ',
// //                               style: TextStyle(color: Colors.white),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
