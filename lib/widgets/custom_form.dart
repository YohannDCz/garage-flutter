import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/authentication_bloc.dart';
import '../model/user_model.dart';
import '../service/validator_service.dart';
import '../theme.dart';
import 'form_field_admin.dart';
import 'title.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.birthdateController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordcontroller,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController birthdateController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordcontroller;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.primary),
      foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(99.0))),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 350.0, vertical: 8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const BigTitle(title: "Admin"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Créer un nouveau profil employé.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                  FormFieldAdmin(
                      text: "Nom complet",
                      hint: "Martin",
                      controller: nameController,
                      validator: ValidatorService.validateName),
                  FormFieldAdmin(
                      text: "Date de naissance",
                      hint: "08/01/1995",
                      controller: birthdateController,
                      validator: ValidatorService.validateBirthdate),
                  FormFieldAdmin(
                      text: "Adresse email",
                      hint: "example@gmail.com",
                      controller: emailController,
                      validator: ValidatorService.validateEmail),
                  FormFieldAdmin(
                      text: "Mot de passe",
                      hint: "••••••••",
                      controller: passwordController,
                      validator: ValidatorService.validatePassword2),
                  FormFieldAdmin(
                      text: "Confirmer le mot de passe",
                      hint: "••••••••",
                      controller: confirmPasswordcontroller,
                      password: passwordController.text,
                      confirmPassword: confirmPasswordcontroller.text),
                  height32,
                  ElevatedButton(
                      onPressed: () => onPressed(context),
                      style: buttonStyle,
                      child: const Text('Créer')),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const BigTitle(title: "Admin"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Créer un nouveau profil employé.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                  FormFieldAdmin(
                      text: "Nom complet",
                      hint: "Martin",
                      controller: nameController,
                      validator: ValidatorService.validateName),
                  FormFieldAdmin(
                      text: "Date de naissance",
                      hint: "08/01/1995",
                      controller: birthdateController,
                      validator: ValidatorService.validateBirthdate),
                  FormFieldAdmin(
                      text: "Adresse email",
                      hint: "example@gmail.com",
                      controller: emailController,
                      validator: ValidatorService.validateEmail),
                  FormFieldAdmin(
                      text: "Mot de passe",
                      hint: "••••••••",
                      controller: passwordController,
                      validator: ValidatorService.validatePassword2),
                  FormFieldAdmin(
                      text: "Confirmer le mot de passe",
                      hint: "••••••••",
                      controller: confirmPasswordcontroller,
                      password: passwordController.text,
                      confirmPassword: confirmPasswordcontroller.text),
                  height32,
                  ElevatedButton(
                      onPressed: () => onPressed(context),
                      style: buttonStyle,
                      child: const Text('Créer')),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void onPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      try {
        BlocProvider.of<AuthenticationBloc>(context).add(
          EmployeeSignUp(
            user: CustomUser(
              name: nameController.text,
              birthdate:
                  DateFormat('dd/MM/yyyy').parse(birthdateController.text),
              email: emailController.text,
              password: passwordController.text,
              type: 'employee',
              created_at: DateTime.now(),
            ),
          ),
        );
        nameController.clear();
        birthdateController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordcontroller.clear();
      } catch (e) {
        debugPrint('$e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Erreur lors de la création de l\'employé.'),
            backgroundColor: AppColors.error));
      }
    }
  }
}
