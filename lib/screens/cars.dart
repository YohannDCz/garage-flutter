import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cars_bloc.dart';
import '../theme.dart';
import '../widgets/car_list.dart';
import '../widgets/filtered_block.dart';
import '../widgets/scaffold/appbar.dart';
import '../widgets/scaffold/drawer.dart';
import '../widgets/title.dart';

class Cars extends StatefulWidget {
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  bool _isFiltering = false;

  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  final minKilometersController = TextEditingController();
  final maxKilometersController = TextEditingController();
  final minYearController = TextEditingController();
  final maxYearController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      setState(() {
        _isFiltering = !_isFiltering;
      });
    }

    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.secondaryText),
      foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );

    Row buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Filtre',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.white)),
        width4,
        Icon(Icons.filter_list, color: AppColors.white),
      ],
    );

    Future onPressedFilter() async {
      setState(() {
        _isFiltering = false;
      });
      BlocProvider.of<CarsBloc>(context).add(
        FilteredCars(
          minPrice: int.tryParse(minPriceController.text),
          maxPrice: int.tryParse(maxPriceController.text),
          minKilometers: int.tryParse(minKilometersController.text),
          maxKilometers: int.tryParse(maxKilometersController.text),
          minYear: int.tryParse(minYearController.text),
          maxYear: int.tryParse(maxYearController.text),
        ),
      );
    }

    ButtonStyle buttonStyleFilter = ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              12), // Remplacez 10 par la valeur que vous voulez
        ));

    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(
        scaffoldKey: scaffoldKey,
      ),
      drawer: const MyDrawer(),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: AppColors.gradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 1200) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 350.0, vertical: 8.0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const BigTitle(title: 'Occasions'),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                  onPressed: onPressed,
                                  style: buttonStyle,
                                  child: buttonContent)),
                          height16,

                          /// The complete list of cars, filtered or not
                          const CarList(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 116.0),
                        child: Visibility(
                          visible: _isFiltering,
                          child: Container(
                            width: double.infinity,
                            height: 270.0,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryText,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FilteredBlock(
                                            label: "Prix minimum",
                                            hint: "3000 (€)",
                                            controller: minPriceController),
                                        FilteredBlock(
                                            label: "Prix maximum",
                                            hint: "300000 (€)",
                                            controller: maxPriceController),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FilteredBlock(
                                            label: "Kilométrage minimum",
                                            hint: "10000 (km)",
                                            controller:
                                                minKilometersController),
                                        FilteredBlock(
                                            label: "Kilométrage maximum",
                                            hint: "100000 (km)",
                                            controller:
                                                maxKilometersController),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FilteredBlock(
                                            label: "Année minimum",
                                            hint: "2000",
                                            controller: minYearController),
                                        FilteredBlock(
                                            label: "Année maximum",
                                            hint: "2024",
                                            controller: maxYearController),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                            onPressed: onPressedFilter,
                                            style: buttonStyleFilter,
                                            child: Text("Appliquer",
                                                style: TextStyle(
                                                    color: AppColors.white)))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const BigTitle(title: 'Occasions'),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                  onPressed: onPressed,
                                  style: buttonStyle,
                                  child: buttonContent)),
                          height16,

                          /// The complete list of cars, filtered or not
                          const CarList(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 116.0),
                        child: Visibility(
                          visible: _isFiltering,
                          child: Container(
                            width: double.infinity,
                            height: 270.0,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryText,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FilteredBlock(
                                            label: "Prix minimum",
                                            hint: "3000 (€)",
                                            controller: minPriceController),
                                        FilteredBlock(
                                            label: "Prix maximum",
                                            hint: "300000 (€)",
                                            controller: maxPriceController),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FilteredBlock(
                                            label: "Kilométrage minimum",
                                            hint: "10000 (km)",
                                            controller:
                                                minKilometersController),
                                        FilteredBlock(
                                            label: "Kilométrage maximum",
                                            hint: "100000 (km)",
                                            controller:
                                                maxKilometersController),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FilteredBlock(
                                            label: "Année minimum",
                                            hint: "2000",
                                            controller: minYearController),
                                        FilteredBlock(
                                            label: "Année maximum",
                                            hint: "2024",
                                            controller: maxYearController),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                            onPressed: onPressedFilter,
                                            style: buttonStyleFilter,
                                            child: Text("Appliquer",
                                                style: TextStyle(
                                                    color: AppColors.white)))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
