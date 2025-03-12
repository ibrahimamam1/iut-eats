import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iut_eats/controllers/location_controller.dart';
import 'package:iut_eats/utils/dimensions.dart';

import '../../../models/prediction_model.dart';


class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: TypeAheadField<NewPrediction>(
            builder: (context, controller, focusNode) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText: "search location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      style: BorderStyle.none,
                      width: 0,
                    ),
                  ),
                  hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).disabledColor,
                    fontSize: Dimensions.font16,
                  ),
                ),
              );
            },
            suggestionsCallback: (pattern) async {
              return await Get.find<LocationController>().searchLocation(context, pattern);
            },
            onSelected: (NewPrediction suggestion) {
              Get.find<LocationController>().setLocation(
                suggestion.placeId,
                suggestion.description,
                mapController,
              );
              Get.back();
            },
            itemBuilder: (context, NewPrediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(Dimensions.width10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    Expanded(
                      child: Text(
                        suggestion.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}