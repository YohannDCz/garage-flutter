import 'package:flutter/material.dart';

import '../model/car_model.dart';
import '../theme.dart';

class CarCard extends StatefulWidget {
  const CarCard({
    Key? key,
    required this.car,
    this.width,
    this.height,
  }) : super(key: key);

  final Car car;
  final double? width;
  final double? height;

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  List<Widget>? equipmentWidgets;

  String centaine(number) {
    return ((number / 100).floor() * 100).toString();
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 526.0,
          maxWidth: widget.width ?? 372.0,
        ),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: Image.network(
                  widget.car.image!,
                  width: double.infinity,
                  height: widget.height ?? 238.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: widget.width ?? 372.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(widget.car.model!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Text.rich(
                            TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontStyle: FontStyle.italic),
                              children: [
                                TextSpan(
                                  text: centaine(widget.car.price),
                                ),
                                const TextSpan(
                                  text: ' €',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      height4,
                      Text(widget.car.type!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.secondaryText)),
                      height4,
                      Text.rich(
                        TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                          children: [
                            TextSpan(
                              text: centaine(widget.car.kilometers),
                            ),
                            const TextSpan(
                              text: ' km, ',
                            ),
                            TextSpan(
                              text: '${widget.car.year}',
                            ),
                          ],
                        ),
                      ),
                      height4,
                      widget.car.equipments == null || widget.width == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Equipements :",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                ...?widget.car.equipments?.map((item) {
                                  return Text("- ${capitalize(item.trim())}");
                                })
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              widget.width != null ? const Spacer() : const SizedBox(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil('/about', (route) => false),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(AppColors.primary),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(AppColors.white),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: const Text('Acheter'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
