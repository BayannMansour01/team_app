import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/core/utils/size_config.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo_impl.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
import 'package:team_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_state.dart';

class ProductDetailsPage extends StatelessWidget {
  final dynamic product;

  const ProductDetailsPage({
    Key? key,
    required this.product,
    // required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppointementsCubit(getIt.get<AppointementsRepoImpl>()),
      child: BlocConsumer<AppointementsCubit, AppointementsState>(
        listener: (context, state) {
          // يمكنك إضافة منطق هنا للاستماع لحالات معينة
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<AppointementsCubit>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                product.name,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppConstants.blueColor, // لون خلفية AppBar
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      "http://${AppConstants.ip}:8000/${product.image}",
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/LOGO.png',
                            fit: BoxFit.cover);
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.orangeColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'السعر: ${product.price} ل.س',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildProductDetails(product),
                    SizedBox(height: 16),
                    Text(
                      product.disc,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(dynamic product) {
    if (product.categoryId == 1) {
      return Text(
        'سعة اللوح الشمسي: ${product.panelCapacity}',
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey[700],
        ),
      );
    } else if (product.categoryId == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نوع البطارية: ${product.batteryType == '2' ? 'ليثيوم' : 'أنبوبية'}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
            ),
          ),
          Text(
            'أمبير البطارية: ${product.batteryAmper}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
            ),
          ),
          Text(
            'فولت البطارية: ${product.batteryVolt}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'استطاعة الانفيرتر: ${product.inverterWatt}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
            ),
          ),
          Text(
            'فولت الانفيرتر: ${product.inverterVolt}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
            ),
          ),
        ],
      );
    }
  }
}
