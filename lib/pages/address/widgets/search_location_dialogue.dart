import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/src/places.dart';


class LocationDialogue extends StatelessWidget {

  final GoogleMapController mapController;
  const LocationDialogue({Key? key, required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller=TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      //alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20/2),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child:TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: "search location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0
                  )
                )
              )
            ),

            onSuggestionSelected: (suggestion){},
            suggestionsCallback: (String pattern) async {
              return await Get.find<LocationConroller>().searchLocation(context, pattern);
            },
            itemBuilder: (context,Prediction suggestion){
              return Row(
                children: [
                  Icon(Icons.location_on),
                  Expanded(child:Text("New Location") )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
