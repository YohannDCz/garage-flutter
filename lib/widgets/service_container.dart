import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/service_model.dart';
import '../service/auth_service.dart';
import '../service/services_service.dart';
import '../theme.dart';

class ServiceContainer extends StatefulWidget {
  const ServiceContainer({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  State<ServiceContainer> createState() => _ServiceContainerState();
}

class _ServiceContainerState extends State<ServiceContainer> {
  bool isEditing = false;
  late TextEditingController labelController =
      TextEditingController(text: widget.service.label);
  late TextEditingController descriptionController =
      TextEditingController(text: widget.service.description);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.network(
                  widget.service.image,
                  fit: BoxFit.cover,
                  height: 100.0,
                  width: 268.0,
                ),
                Visibility(
                  visible:
                      context.read<AuthenticationService>().typeOfLoggedUser ==
                          'admin',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 32.0,
                      height: 32.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isEditing) {
                            context.read<ServicesService>().updateService(
                                  Service(
                                    id: widget.service.id,
                                    category: widget.service.category,
                                    label: labelController.text,
                                    description: descriptionController.text,
                                    image: widget.service.image,
                                    created_at: widget.service.created_at,
                                  ),
                                );
                          }
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              isEditing ? AppColors.accent1 : AppColors.white),
                          foregroundColor: WidgetStateProperty.all<Color>(
                              AppColors.primaryText),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(99.0))),
                          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.zero),
                        ),
                        child: const Icon(Icons.edit, size: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 268.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                controller: labelController,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 268.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: !isEditing,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                maxLines: 4,
                controller: descriptionController,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
