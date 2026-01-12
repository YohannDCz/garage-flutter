// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../bloc/cars_bloc.dart';
import '../bloc/ratings_bloc.dart';
import '../model/car_model.dart';
import '../service/cars_service.dart';
import '../service/ratings_service.dart';
import '../service/validator_service.dart';
import '../theme.dart';
import '../widgets/dialog.dart';
import '../widgets/form_fields/form_field_label.dart';
import '../widgets/ratings.dart';
import '../widgets/scaffold/appbar.dart';
import '../widgets/scaffold/drawer.dart';
import '../widgets/spinner.dart';
import '../widgets/title.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  dynamic imageUrl;
  XFile? image;
  bool isLoading = false;

  final modelController = TextEditingController();
  final typeController = TextEditingController();
  final kilometerController = TextEditingController();
  final priceController = TextEditingController();
  final yearController = TextEditingController();
  final equipmentsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }

  Future<String> uploadImage(XFile image) async {
    String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    try {
      final file = File(image.path);
      await Supabase.instance.client.storage
          .from('cars')
          .upload(fileName, file);
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
    final imageUrl = Supabase.instance.client.storage
        .from('cars')
        .getPublicUrl(fileName)
        .toString();
    return imageUrl;
  }

  @override
  void initState() {
    BlocProvider.of<RatingsBloc>(context).add(FetchFilteredRatings());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.primary),
      foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(99.0))),
    );

    Future onPressed() async {
      setState(() {
        isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        try {
          if (image != null) {
            imageUrl = await uploadImage(image!);
          }
          BlocProvider.of<CarsBloc>(context).add(NewCar(
            car: Car(
              model: modelController.text,
              type: typeController.text,
              kilometers: int.parse(kilometerController.text),
              price: int.parse(priceController.text),
              year: int.parse(yearController.text),
              equipments: equipmentsController.text
                  .split('\n')
                  .map((equipment) => equipment.trim())
                  .toList(),
              image: imageUrl,
            ),
          ));
        } catch (e) {
          debugPrint("$e");
          showDialog(
            context: context,
            builder: (context) => const CustomDialog(
              title: "Erreur",
              message: "Une erreur est survenue lors de l'ajout de la voiture",
            ),
          );
        }
      }
      setState(() {
        isLoading = false;
      });
    }

    /// We combine the two streams to display the snackbar
    final combinedStream = Rx.combineLatest2(
      context.read<RatingsService>().snackbarStream,
      context.read<CarsService>().snackbarStream,
      (rating, car) => 'Rating: $rating, Car: $car',
    );

    return StreamBuilder<String>(
      stream: combinedStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(snapshot.data!),
                backgroundColor: AppColors.primaryText));
          });
        }
        return Scaffold(
          key: scaffoldKey,
          appBar: MyAppBar(scaffoldKey: scaffoldKey),
          drawer: const MyDrawer(),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(gradient: AppColors.gradient),
            child: SafeArea(
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1200) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 350.0, vertical: 8.0),
                        child: Column(
                          children: [
                            const BigTitle(title: 'Ajouter une voiture'),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.0)),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FormFieldLabel(
                                          label: "Modèle",
                                          controller: modelController,
                                          hint: "Peugeot 406",
                                          validator:
                                              ValidatorService.validateLabel),
                                      height8,
                                      FormFieldLabel(
                                          label: "Type",
                                          controller: typeController,
                                          hint: "Éléctrique",
                                          validator:
                                              ValidatorService.validateLabel),
                                      height8,
                                      FormFieldLabel(
                                          label: "Kilométrage",
                                          controller: kilometerController,
                                          hint: "10000 km",
                                          validator:
                                              ValidatorService.validateNumber),
                                      height8,
                                      FormFieldLabel(
                                          label: "Prix",
                                          controller: priceController,
                                          hint: "3000€",
                                          validator:
                                              ValidatorService.validateNumber),
                                      height8,
                                      FormFieldLabel(
                                          label: "Année de mise en circulation",
                                          controller: yearController,
                                          hint: "2000",
                                          validator:
                                              ValidatorService.validateNumber),
                                      height8,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text("Image",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 54.0,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              isLoading = true;
                                              image = await pickImage();
                                              isLoading = false;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.accent1,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0)),
                                            child: image != null
                                                ? Text("Image Choisie!",
                                                    style: TextStyle(
                                                        color: AppColors.white))
                                                : Text('Choisir une image',
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.white))),
                                      ),
                                      height8,
                                      FormFieldLabel(
                                          label: "Équipements",
                                          controller: equipmentsController,
                                          hint:
                                              "Bluetooth\n- Interieur cuir\n- Climatisation\n- Jantes alliage\n- Régulateur de vitesse",
                                          maxLines: 12),
                                      height8,
                                      ElevatedButton(
                                          onPressed: onPressed,
                                          style: buttonStyle,
                                          child: isLoading
                                              ? const Spinner()
                                              : const Text('Envoyer')),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            height16,
                            const BigTitle(title: "Modération avis"),
                            Ratings(
                                buttons: true, fetch: FetchFilteredRatings()),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          children: [
                            const BigTitle(title: 'Ajouter une voiture'),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.0)),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FormFieldLabel(
                                          label: "Modèle",
                                          controller: modelController,
                                          hint: "Peugeot 406",
                                          validator:
                                              ValidatorService.validateLabel),
                                      height8,
                                      FormFieldLabel(
                                          label: "Type",
                                          controller: typeController,
                                          hint: "Éléctrique",
                                          validator:
                                              ValidatorService.validateLabel),
                                      height8,
                                      FormFieldLabel(
                                          label: "Kilométrage",
                                          controller: kilometerController,
                                          hint: "10000 km",
                                          validator:
                                              ValidatorService.validateNumber),
                                      height8,
                                      FormFieldLabel(
                                          label: "Prix",
                                          controller: priceController,
                                          hint: "3000€",
                                          validator:
                                              ValidatorService.validateNumber),
                                      height8,
                                      FormFieldLabel(
                                          label: "Année de mise en circulation",
                                          controller: yearController,
                                          hint: "2000",
                                          validator:
                                              ValidatorService.validateNumber),
                                      height8,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text("Image",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 54.0,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              isLoading = true;
                                              image = await pickImage();
                                              isLoading = false;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.accent1,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0)),
                                            child: image != null
                                                ? Text("Image Choisie!",
                                                    style: TextStyle(
                                                        color: AppColors.white))
                                                : Text('Choisir une image',
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.white))),
                                      ),
                                      height8,
                                      FormFieldLabel(
                                          label: "Équipements",
                                          controller: equipmentsController,
                                          hint:
                                              "Bluetooth\n- Interieur cuir\n- Climatisation\n- Jantes alliage\n- Régulateur de vitesse",
                                          maxLines: 12),
                                      height8,
                                      ElevatedButton(
                                          onPressed: onPressed,
                                          style: buttonStyle,
                                          child: isLoading
                                              ? const Spinner()
                                              : const Text('Envoyer')),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            height16,
                            const BigTitle(title: "Modération avis"),
                            Ratings(
                                buttons: true, fetch: FetchFilteredRatings()),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
