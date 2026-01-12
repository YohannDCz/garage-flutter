import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication_bloc.dart';
import '../theme.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withValues(alpha: 0.1))
        ],
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height16,
          Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          height8,
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          height8,
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(ReAuthenticate());
                Navigator.pop(context);
              },
              child: const Text("Fermer"),
            ),
          )
        ],
      ),
    );
  }
}
