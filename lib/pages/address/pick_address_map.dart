import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:iut_eats/controllers/checkout_controller.dart';
import 'package:iut_eats/controllers/location_controller.dart';
import 'package:iut_eats/utils/colors.dart';

import '../../base/custom_button.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final bool fromCheckout;
  final GoogleMapController? googleMapController;
  const PickAddressMap({super.key, required this.fromSignup, required this.fromAddress, required this.fromCheckout,this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  void initState() {
    super.initState();
    print("Address list empty? ${Get.find<LocationController>().addressList.isEmpty}");
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(23.9482, 90.3778);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      print("Set initial position to IUT: $_initialPosition");
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        var latitude = Get.find<LocationController>().getAddress["Latitude"];
        var longitude = Get.find<LocationController>().getAddress["longitude"];
        print("Address data: Latitude=$latitude, Longitude=$longitude");

        _initialPosition = LatLng(
          latitude != null ? double.parse(latitude) : 23.9482,
          longitude != null ? double.parse(longitude) : 90.3778,
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
        print("Set initial position from address: $_initialPosition");
      }
    }
  }

  // void initState(){
  //
  //   super.initState();
  //   if(Get.find<LocationController>().addressList.isEmpty){
  //     _initialPosition=const LatLng(45.521563, -122.677433);
  //     _cameraPosition=CameraPosition(target: _initialPosition,zoom: 17);
  //   }else{
  //     if(Get.find<LocationController>().addressList.isNotEmpty){
  //       _initialPosition=LatLng(double.parse(Get.find<LocationController>().getAddress["Latitude"]),
  //           double.parse(Get.find<LocationController>().getAddress["longitude"]));
  //       _cameraPosition=CameraPosition(target: _initialPosition, zoom: 17);
  //     }
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 17,
                    ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                      "assets/image/pick_marker.png",
                      height: 50,
                      width: 50,
                    )
                        : CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, size: 25, color: AppColors.yellowColor),
                          Expanded(
                            child: Text(
                              locationController.pickPlacemark.name ?? '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.font16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: locationController.isLoading?Center(child: CircularProgressIndicator(),): CustomButton(

                      buttonText: locationController.inZone?widget.fromAddress? 'Pick Address': 'Pick Location':'Service is not available in your area',
                      onPressed: (locationController.buttonDisabled||locationController.loading)
                          ? null
                          : () {
                        if (locationController.pickPosition.latitude != 0 &&
                            locationController.pickPlacemark.name != null) {
                          if (widget.fromAddress) {
                            if (widget.googleMapController != null) {
                              print("Now you clicked on this");
                              widget.googleMapController!.moveCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      locationController.pickPosition.latitude,
                                      locationController.pickPosition.longitude,
                                    ),
                                  ),
                                ),
                              );
                              locationController.setAddressData();
                            }
                            locationController.setAddressData();
                            Get.back();
                            //if update problem
                            //Get.toNamed(RouteHelper.getCheckoutPage());
                          }else if(widget.fromCheckout){
                            print("map from checkout");
                            if (widget.googleMapController != null) {
                              widget.googleMapController!.moveCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      locationController.pickPosition.latitude,
                                      locationController.pickPosition.longitude,
                                    ),
                                  ),
                                ),
                              );
                            }
                            locationController.setAddressData();
                            CheckoutController checkoutController = Get.find<CheckoutController>();
                            checkoutController.updateAddress();
                            Get.back();
                          }

                        }
                      },
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }


}
