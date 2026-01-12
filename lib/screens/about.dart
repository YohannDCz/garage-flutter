import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/email_bloc.dart';
import '../bloc/schedule_bloc.dart';
import '../model/email_model.dart';
import '../model/schedules_model.dart';
import '../service/auth_service.dart';
import '../service/email_service.dart';
import '../service/validator_service.dart';
import '../theme.dart';
import '../widgets/form_fields/form_field_hint.dart';
import '../widgets/scaffold/appbar.dart';
import '../widgets/scaffold/drawer.dart';
import '../widgets/schedule.dart';
import '../widgets/title.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool isEditing = false;

  final mondayController = TextEditingController();
  final tuesdayController = TextEditingController();
  final wednesdayController = TextEditingController();
  final thursdayController = TextEditingController();
  final fridayController = TextEditingController();
  final saturdayController = TextEditingController();
  final sundayController = TextEditingController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    BlocProvider.of<SchedulesBloc>(context).add(const GetSchedules());
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.primary),
      foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(99.0))),
    );

    return StreamBuilder<String>(
        stream: context.read<EmailService>().snackbarStream,
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
                              const BigTitle(title: 'Horaires'),
                              BlocBuilder<SchedulesBloc, SchedulesState>(
                                builder: (context, state) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Lundi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Mardi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Mercredi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Jeudi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Vendredi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Samedi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Dimanche',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                ],
                                              ),
                                              width32,
                                              if (state is SchedulesFetchReady)
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            mondayController,
                                                        label: state
                                                            .schedules.monday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            tuesdayController,
                                                        label: state
                                                            .schedules.tuesday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            wednesdayController,
                                                        label: state.schedules
                                                            .wednesday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            thursdayController,
                                                        label: state.schedules
                                                            .thursday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            fridayController,
                                                        label: state
                                                            .schedules.friday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            saturdayController,
                                                        label: state.schedules
                                                            .saturday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            sundayController,
                                                        label: state
                                                            .schedules.sunday),
                                                    height6,
                                                  ],
                                                )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Visibility(
                                              visible: context
                                                      .read<
                                                          AuthenticationService>()
                                                      .typeOfLoggedUser ==
                                                  'admin',
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 32.0,
                                                  height: 32.0,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (isEditing) {
                                                        BlocProvider.of<
                                                                    SchedulesBloc>(
                                                                context)
                                                            .add(
                                                          UpdateSchedules(
                                                            SchedulesModel(
                                                              monday:
                                                                  mondayController
                                                                      .text,
                                                              tuesday:
                                                                  tuesdayController
                                                                      .text,
                                                              wednesday:
                                                                  wednesdayController
                                                                      .text,
                                                              thursday:
                                                                  thursdayController
                                                                      .text,
                                                              friday:
                                                                  fridayController
                                                                      .text,
                                                              saturday:
                                                                  saturdayController
                                                                      .text,
                                                              sunday:
                                                                  sundayController
                                                                      .text,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      setState(() {
                                                        isEditing = !isEditing;
                                                      });
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty.all<
                                                                  Color>(
                                                              isEditing
                                                                  ? AppColors
                                                                      .accent1
                                                                  : AppColors
                                                                      .white),
                                                      foregroundColor:
                                                          WidgetStateProperty.all<
                                                                  Color>(
                                                              AppColors
                                                                  .primaryText),
                                                      shape: WidgetStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          99.0))),
                                                      padding: WidgetStateProperty
                                                          .all<EdgeInsetsGeometry>(
                                                              EdgeInsets.zero),
                                                    ),
                                                    child: const Icon(
                                                        Icons.edit,
                                                        size: 16.0),
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
                              const BigTitle(title: 'Contact'),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(16.0)),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('Adresse:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          height40,
                                          Text('Téléphone:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ],
                                      ),
                                      width8,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              '2-20 Avenue Président Salvador Allende,\nMozinor,\n93100 Montreuil',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text('01.48.57.33.49',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              height16,
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(16.0)),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FormFieldHint(
                                            nameController: nameController,
                                            hint: 'Nom complet',
                                            validator:
                                                ValidatorService.validateName),
                                        height8,
                                        FormFieldHint(
                                            nameController: phoneController,
                                            hint: 'Numéro de téléphone',
                                            validator:
                                                ValidatorService.validatePhone),
                                        height8,
                                        FormFieldHint(
                                            nameController: emailController,
                                            hint: 'Adresse email',
                                            validator: ValidatorService
                                                .validateEmail2),
                                        height8,
                                        FormFieldHint(
                                            nameController: messageController,
                                            hint: 'Message',
                                            validator: ValidatorService
                                                .validateMessage,
                                            maxLines: 12),
                                        height8,
                                        ElevatedButton(
                                            onPressed: onPressed,
                                            style: buttonStyle,
                                            child: const Text('Envoyer')),
                                      ],
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
                          child: Column(
                            children: [
                              const BigTitle(title: 'Horaires'),
                              BlocBuilder<SchedulesBloc, SchedulesState>(
                                builder: (context, state) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Lundi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Mardi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Mercredi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Jeudi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Vendredi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Samedi',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  height16,
                                                  Text('Dimanche',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                ],
                                              ),
                                              width32,
                                              if (state is SchedulesFetchReady)
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    height16,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            mondayController,
                                                        label: state
                                                            .schedules.monday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            tuesdayController,
                                                        label: state
                                                            .schedules.tuesday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            wednesdayController,
                                                        label: state.schedules
                                                            .wednesday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            thursdayController,
                                                        label: state.schedules
                                                            .thursday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            fridayController,
                                                        label: state
                                                            .schedules.friday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            saturdayController,
                                                        label: state.schedules
                                                            .saturday),
                                                    height6,
                                                    Schedule(
                                                        readOnly: !isEditing,
                                                        controller:
                                                            sundayController,
                                                        label: state
                                                            .schedules.sunday),
                                                    height6,
                                                  ],
                                                )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Visibility(
                                              visible: context
                                                      .read<
                                                          AuthenticationService>()
                                                      .typeOfLoggedUser ==
                                                  'admin',
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 32.0,
                                                  height: 32.0,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (isEditing) {
                                                        BlocProvider.of<
                                                                    SchedulesBloc>(
                                                                context)
                                                            .add(
                                                          UpdateSchedules(
                                                            SchedulesModel(
                                                              monday:
                                                                  mondayController
                                                                      .text,
                                                              tuesday:
                                                                  tuesdayController
                                                                      .text,
                                                              wednesday:
                                                                  wednesdayController
                                                                      .text,
                                                              thursday:
                                                                  thursdayController
                                                                      .text,
                                                              friday:
                                                                  fridayController
                                                                      .text,
                                                              saturday:
                                                                  saturdayController
                                                                      .text,
                                                              sunday:
                                                                  sundayController
                                                                      .text,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      setState(() {
                                                        isEditing = !isEditing;
                                                      });
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty.all<
                                                                  Color>(
                                                              isEditing
                                                                  ? AppColors
                                                                      .accent1
                                                                  : AppColors
                                                                      .white),
                                                      foregroundColor:
                                                          WidgetStateProperty.all<
                                                                  Color>(
                                                              AppColors
                                                                  .primaryText),
                                                      shape: WidgetStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          99.0))),
                                                      padding: WidgetStateProperty
                                                          .all<EdgeInsetsGeometry>(
                                                              EdgeInsets.zero),
                                                    ),
                                                    child: const Icon(
                                                        Icons.edit,
                                                        size: 16.0),
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
                              const BigTitle(title: 'Contact'),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(16.0)),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('Adresse:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          height40,
                                          Text('Téléphone:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ],
                                      ),
                                      width8,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              '2-20 Avenue Président Salvador Allende,\nMozinor,\n93100 Montreuil',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text('01.48.57.33.49',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              height16,
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(16.0)),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FormFieldHint(
                                            nameController: nameController,
                                            hint: 'Nom complet',
                                            validator:
                                                ValidatorService.validateName),
                                        height8,
                                        FormFieldHint(
                                            nameController: phoneController,
                                            hint: 'Numéro de téléphone',
                                            validator:
                                                ValidatorService.validatePhone),
                                        height8,
                                        FormFieldHint(
                                            nameController: emailController,
                                            hint: 'Adresse email',
                                            validator: ValidatorService
                                                .validateEmail2),
                                        height8,
                                        FormFieldHint(
                                            nameController: messageController,
                                            hint: 'Message',
                                            validator: ValidatorService
                                                .validateMessage,
                                            maxLines: 12),
                                        height8,
                                        ElevatedButton(
                                            onPressed: onPressed,
                                            style: buttonStyle,
                                            child: const Text('Envoyer')),
                                      ],
                                    ),
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
            ),
          );
        });
  }

  void onPressed() {
    if (_formKey.currentState!.validate()) {
      try {
        BlocProvider.of<EmailBloc>(context).add(
          EmailSendReady(
            email: Email(
              name: nameController.text,
              address: emailController.text,
              phone: phoneController.text,
              message: messageController.text,
            ),
          ),
        );
        // nameController.clear();
        // emailController.clear();
        // phoneController.clear();
        // messageController.clear();
      } catch (e) {
        debugPrint('Erreur lors de l\'envoi du mail : $e');
      }
    }
  }
}
