import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../assets.dart';
import '../bloc/cars_bloc.dart';
import '../bloc/ratings_bloc.dart';
import '../model/rating_model.dart';
import '../service/validator_service.dart';
import '../theme.dart';
import '../widgets/car_card.dart';
import '../widgets/form_fields/form_field_label.dart';
import '../widgets/ratings.dart';
import '../widgets/scaffold/appbar.dart';
import '../widgets/scaffold/drawer.dart';
import '../widgets/spinner.dart';
import '../widgets/title.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;

  final titleController = TextEditingController();
  final rateController = TextEditingController();
  final messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<RatingsBloc>(context).add(FetchRatings());
    BlocProvider.of<CarsBloc>(context).add(GetInitialCars());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future onPressed() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        try {
          BlocProvider.of<RatingsBloc>(context).add(
            AddRating(
              rating: Rating(
                title: titleController.text,
                rate: int.parse(rateController.text),
                comment: messageController.text,
                validated: false,
                deleted: false,
              ),
            ),
          );
        } catch (e) {
          debugPrint("$e");
        }
        BlocProvider.of<RatingsBloc>(context).add(FetchRatings());
        titleController.clear();
        rateController.clear();
        messageController.clear();
        setState(() {
          isLoading = false;
        });
      }
    }

    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.primary),
      foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(99.0))),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(scaffoldKey: scaffoldKey),
      drawer: const MyDrawer(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.gradient),
        child: SingleChildScrollView(
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1200) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 350.0, vertical: 8.0),
                    child: Column(
                      children: [
                        const BigTitle(title: "Accueil"),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.0)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Services',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  height: 432.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Card(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 286.0,
                                                  height: 124.0,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    12.0)),
                                                    child: Image.network(
                                                      assets[index]["image"]!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    assets[index]["titre"]!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 270.0,
                                                    child: Text(
                                                      assets[index]
                                                          ["description"]!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Card(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 286.0,
                                                height: 124.0,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  12.0)),
                                                  child: Image.network(
                                                    assets[index]["image"]!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  assets[index]["titre"]!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 270.0,
                                                  child: Text(
                                                    assets[index]
                                                        ["description"]!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        height16,
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.0)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Occasions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  height: 400.0,
                                  child: BlocBuilder<CarsBloc, CarsState>(
                                    builder: (context, state) {
                                      if (state is CarFetchReady) {
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.cars.length,
                                          itemBuilder: (context, index) {
                                            var car = state.cars[index];
                                            if (index == 0) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: CarCard(
                                                    car: car,
                                                    width: 285.0,
                                                    height: 200),
                                              );
                                            } else {
                                              return CarCard(
                                                  car: car,
                                                  width: 285.0,
                                                  height: 200);
                                            }
                                          },
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        height16,
                        Ratings(buttons: false, fetch: FetchRatings()),
                        height16,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text("Ajouter un avis",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .underline))),
                                  FormFieldLabel(
                                      label: "Titre",
                                      controller: titleController,
                                      hint: "Super garage !",
                                      validator:
                                          ValidatorService.validateLabel),
                                  height8,
                                  FormFieldLabel(
                                      label: "Note",
                                      controller: rateController,
                                      hint: "4",
                                      validator: ValidatorService.validateRate),
                                  height8,
                                  FormFieldLabel(
                                    label: "Message",
                                    controller: messageController,
                                    hint:
                                        "Je pense que ce garage a de l'avenir. En effet, il m'a aidé dans toute mes démarches !",
                                    validator: ValidatorService.validateLabel,
                                    maxLines: 12,
                                  ),
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
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        const BigTitle(title: "Accueil"),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.0)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Services',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  height: 432.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Card(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 286.0,
                                                  height: 124.0,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    12.0)),
                                                    child: Image.network(
                                                      assets[index]["image"]!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    assets[index]["titre"]!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 270.0,
                                                    child: Text(
                                                      assets[index]
                                                          ["description"]!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Card(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 286.0,
                                                height: 124.0,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  12.0)),
                                                  child: Image.network(
                                                    assets[index]["image"]!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  assets[index]["titre"]!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 270.0,
                                                  child: Text(
                                                    assets[index]
                                                        ["description"]!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        height16,
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.0)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Occasions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  height: 400.0,
                                  child: BlocBuilder<CarsBloc, CarsState>(
                                    builder: (context, state) {
                                      if (state is CarFetchReady) {
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.cars.length,
                                          itemBuilder: (context, index) {
                                            var car = state.cars[index];
                                            if (index == 0) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: CarCard(
                                                    car: car,
                                                    width: 285.0,
                                                    height: 200),
                                              );
                                            } else {
                                              return CarCard(
                                                  car: car,
                                                  width: 285.0,
                                                  height: 200);
                                            }
                                          },
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        height16,
                        Ratings(buttons: false, fetch: FetchRatings()),
                        height16,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text("Ajouter un avis",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .underline))),
                                  FormFieldLabel(
                                      label: "Titre",
                                      controller: titleController,
                                      hint: "Super garage !",
                                      validator:
                                          ValidatorService.validateLabel),
                                  height8,
                                  FormFieldLabel(
                                      label: "Note",
                                      controller: rateController,
                                      hint: "4",
                                      validator: ValidatorService.validateRate),
                                  height8,
                                  FormFieldLabel(
                                    label: "Message",
                                    controller: messageController,
                                    hint:
                                        "Je pense que ce garage a de l'avenir. En effet, il m'a aidé dans toute mes démarches !",
                                    validator: ValidatorService.validateLabel,
                                    maxLines: 12,
                                  ),
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
  }
}
