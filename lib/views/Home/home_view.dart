// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fikisha/models/favorite_item_model.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Authentication/mobile_auth.dart';
import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/views/Home/build_trip_details.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/views/Home/schedule_trip.dart';
import 'Components/rydr_drawer.dart';
import 'Components/sheet_header.dart';

class Homeview extends StatefulWidget {
  const Homeview({Key? key}) : super(key: key);

  @override
  _HomeviewState createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController placetexteditingcontroller = TextEditingController();
  late GoogleMapController controller;
  List<Marker> markers = [];
  LatLng? destination;

final LatLng center = const LatLng(-1.286389, 36.817223);
  void onMapCreated(GoogleMapController mapController) {
    controller = mapController;
  }

      @override
  void initState() {
    super.initState();
    // loadRiders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: ColorPath.primarywhite,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: ColorPath.primarydark,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 5, bottom: 5),
                child: Container(
                  width: 45,
                  decoration: const BoxDecoration(
                      color: ColorPath.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      ImagesAsset.drawer,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ).ripple(() {
                  _key.currentState!.openDrawer();
                }),
              )
            ],
            centerTitle: false,
            title: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, Warren 👋🏾",
                  style: TextStyle(
                    color: ColorPath.primarywhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "Order a delivery now!",
                  style: TextStyle(
                    color: ColorPath.primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          )
          ),
      drawer: const RyderDrawer(),
      body: Stack(
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 1500),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: center, zoom: 12),
              onMapCreated: onMapCreated,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  duration: const Duration(milliseconds: 2000),
                  child: AnimatedContainer(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 100),
                      alignment: Alignment.bottomCenter,
                      height: 300,
                      width: context.screenWidth(),
                      decoration: const BoxDecoration(
                          color: ColorPath.primarywhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0))),
                      child: Column(
                        children: [
                          const YMargin(7.0),
                          Container(
                              width: 80,
                              height: 2.875,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(80)),
                                color: ColorPath.primaryColor.withOpacity(0.5),
                              )),
                          const YMargin(20),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                const CustomPlaceHolder(),
                                const YMargin(10),
                                SizedBox(
                                  height: 130,
                                  width: context.screenWidth(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: favs.length,
                                        physics:
                                            const RangeMaintainingScrollPhysics(),
                                        itemBuilder: (BuildContext context, i) {
                                          return Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                child: FavoriteItems(
                                                  icon: favs[i].icon,
                                                  time: favs[i].time,
                                                  text: favs[i].text,
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                                const YMargin(10),
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 30),
                                    child: Container(
                                      height: 40,
                                      width: context.screenWidth() - 100,
                                      decoration: BoxDecoration(
                                        color: ColorPath.secondarygrey,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          selectFavorite(context);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Set favorite locations",
                                              style: TextStyle(
                                                color: ColorPath.primarywhite,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  selectFavorite(BuildContext context) {
    TextEditingController favoritetextEditingController =
        TextEditingController();
    TextEditingController favoriteaddresstextEditingController =
        TextEditingController();
    setState(() {
      showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.only(top: 7),
              height: context.screenHeight() / 1.8,
              width: context.screenWidth(),
              decoration: const BoxDecoration(
                color: ColorPath.primarywhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  sheetHeader(),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Column(
                      children: [
                        const YMargin(15),
                        const Text(
                          "Set favorite location",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: ColorPath.primarydark,
                          ),
                        ),
                        const Text(
                          "Pick a favorite location to enable quick access",
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w300,
                            color: ColorPath.offBlack,
                          ),
                        ),
                        const YMargin(10),
                        const DotWidget(
                          dashColor: ColorPath.primaryfield,
                          dashHeight: 1.0,
                          dashWidth: 2.0,
                        ),
                        const YMargin(10),
                        CustomTextFieldWidget(
                          controller: favoritetextEditingController,
                          keyboardType: TextInputType.streetAddress,
                          autofill: const [AutofillHints.addressCityAndState],
                          hintText: 'Enter favorite location',
                        ),
                        const YMargin(10),
                        CustomTextFieldWidget(
                          controller: favoriteaddresstextEditingController,
                          keyboardType: TextInputType.streetAddress,
                          autofill: const [AutofillHints.addressCityAndState],
                          hintText: 'Enter favorite address',
                        ),
                        const YMargin(10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0),
                              child: Text(
                                "Pick a favorite location to enable quick access",
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w300,
                                  color: ColorPath.offBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const YMargin(10),
                        SizedBox(
                          height: 100,
                          width: context.screenWidth() / 1.2,
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 4,
                              mainAxisSpacing: 30,
                              mainAxisExtent: 50,
                              crossAxisSpacing: 10,
                            ),
                            padding: const EdgeInsets.only(left: 20),
                            scrollDirection: Axis.horizontal,
                            children: AppData.favsitems
                                .map((favoriteLists) => FavoriteCard(
                                    favoriteLists: favoriteLists,
                                    onSelected: (model) {
                                      setState(() {
                                        for (var item in AppData.favsitems) {
                                          item.isSelected = false;
                                        }
                                        model.isSelected = true;
                                      });
                                    }))
                                .toList(),
                          ),
                        ),
                        const YMargin(7),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Container(
                            height: 40,
                            width: context.screenWidth(),
                            decoration: BoxDecoration(
                              color: ColorPath.primarydark,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Set  favorite locations",
                                    style: TextStyle(
                                      color: ColorPath.primarywhite,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}

class FavoriteItems extends StatelessWidget {
  final String icon;
  final String text;
  final String time;

  const FavoriteItems({
    required this.icon,
    required this.text,
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: 120,
        width: 110,
        decoration: BoxDecoration(
            border: Border.all(color: ColorPath.primaryColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            )),
        child: Column(
          children: [
            const YMargin(10),
            Container(
              height: 67,
              width: 67,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF5F6F5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SvgPicture.asset(icon, height: 26, width: 26),
              ),
            ),
            const YMargin(5.0),
            Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: ColorPath.primarydark,
              ),
            ),
            const YMargin(5.0),
            Text(
              time,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w400,
                color: Color(0xFF999393),
              ),
            ),
          ],
        ),
      ).ripple(() {}),
    );
  }
}

class CustomPlaceTextWidget extends StatelessWidget {
  final ValueChanged<String>? onSubmitted;
  final Widget suffix;
  final Widget prefix;
  final String hintText;

  final TextEditingController placetexteditingcontroller =
      TextEditingController();
  CustomPlaceTextWidget(
      {this.onSubmitted,
      required this.suffix,
      required this.prefix,
      required this.hintText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30),
      height: 55,
      width: context.screenWidth() - 60,
      child: TextField(
        scrollPadding: const EdgeInsets.symmetric(vertical: 15),
        onSubmitted: onSubmitted,
        controller: placetexteditingcontroller,
        cursorColor: ColorPath.primaryblack,
        keyboardType: TextInputType.streetAddress,
        autofillHints: const [AutofillHints.addressCity],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          prefixIcon: prefix,
          suffix: suffix,
          filled: true,
          fillColor: ColorPath.primaryfield.withOpacity(0.3),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: ColorPath.primaryfield,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          hintStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: ColorPath.primarydark.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

class PrefixIcon1 extends StatelessWidget {
  const PrefixIcon1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(ImagesAsset.car, height: 15, width: 15),
    );
  }
}

class PrefixIcon2 extends StatelessWidget {
  const PrefixIcon2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SvgPicture.asset(
        ImagesAsset.locate,
        color: ColorPath.primarydark.withOpacity(0.5),
        height: 10,
        width: 10,
      ),
    );
  }
}

class SuffixNow1 extends StatelessWidget {
  const SuffixNow1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Container(
          height: 25,
          width: 60,
          decoration: const BoxDecoration(
              color: ColorPath.primarydark,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer_outlined,
                size: 13.0,
                color: ColorPath.primarywhite,
              ),
              Text(
                "Now",
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                  color: ColorPath.primarywhite,
                ),
              )
            ],
          )).ripple(() {
        scheduleTrip(context);
      }),
    );
  }
}

class SuffixNow2 extends StatelessWidget {
  const SuffixNow2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          scheduleTrip(context);
        },
        child: Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
                color: ColorPath.primarydark,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: const Icon(
              Icons.add,
              size: 12.0,
              color: ColorPath.primarywhite,
            )));
  }
}

class CustomPlaceHolder extends StatefulWidget {
  const CustomPlaceHolder({Key? key}) : super(key: key);

  @override
  State<CustomPlaceHolder> createState() => _CustomPlaceHolderState();
}

class _CustomPlaceHolderState extends State<CustomPlaceHolder> {
  final locationController = TextEditingController();
  late GoogleMapController controller;

    void onMapCreated(GoogleMapController mapController) {
    controller = mapController;
  }

  void searchLocations() async {
    final query = locationController.text;
    if (query.isEmpty) {
      return;
    }
    try {
      final locations = await locationFromAddress(query);
      if (locations.isEmpty) {
        return;
      }
      final lng = LatLng(locations.first.latitude, locations.first.longitude);
      controller.animateCamera(CameraUpdate.newLatLngZoom(lng, 15));
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 55,
        width: context.screenWidth(),        
        child:TextField(
              controller: locationController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Where to ?',
                    suffixIcon: IconButton(
                      onPressed: searchLocations,
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    prefixIcon: Icon(
                        Icons.drive_eta_rounded,
                        color: ColorPath.primaryColor.withOpacity(0.3),
                        size: 30,
                      ),),
            ), 
      // ).ripple(() {
      //   showModalBottomSheet(
      //       isDismissible: true,
      //       isScrollControlled: true,
      //       elevation: 0,
      //       backgroundColor: Colors.transparent,
      //       clipBehavior: Clip.hardEdge,
      //       context: context,
      //       builder: (context) {
      //         return Container(
      //           padding: const EdgeInsets.only(top: 7),
      //           height: context.screenHeight() - 118,
      //           width: context.screenWidth(),
      //           decoration: const BoxDecoration(
      //             color: ColorPath.primarywhite,
      //             borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(15),
      //               topRight: Radius.circular(15),
      //             ),
      //           ),
      //           child: pickLocation(context),
      //         );
      //       });
      // }
      // ),
    ));
  }

  Widget pickLocation(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            sheetHeader(),
            const YMargin(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  SvgPicture.asset(ImagesAsset.side),
                  Column(
                    children: [
                      CustomPlaceTextWidget(
                        hintText: "Current location",
                        onSubmitted: (_) {
                          buildTripDetails(context);
                        },
                        suffix: const SuffixNow1(),
                        prefix: const PrefixIcon1(),
                      ),
                      const YMargin(5.0),
                      CustomPlaceTextWidget(
                        hintText: "Your current location",
                        onSubmitted: (_) {
                          buildTripDetails(context);
                        },
                        suffix: const SuffixNow2(),
                        prefix: const PrefixIcon2(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            SvgPicture.asset(ImagesAsset.stopwatch),
            const YMargin(10),
            const Text(
              "Consider the time and don’t keep the rider waiting.",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: ColorPath.primarydark,
              ),
            ),
            const YMargin(10),
            const Text(
              "You will be charged an additional Ksh50 for every minute you \nkeep the rider waiting",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.w400,
                color: Color(0xFF999393),
              ),
            ),
            const YMargin(15),
            Container(
              height: 70,
              width: context.screenWidth(),
              decoration: const BoxDecoration(
                color: ColorPath.primarydark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImagesAsset.globe),
                    const XMargin(5.0),
                    const Text(
                      "Search on Map",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorPath.primarywhite,
                      ),
                    )
                  ]),
            ),
          ],
        )
      ],
    );
  }
}

class FavoriteCard extends StatefulWidget {
  final FavoriteLists favoriteLists;
  final ValueChanged<FavoriteLists> onSelected;
  const FavoriteCard({
    Key? key,
    required this.favoriteLists,
    required this.onSelected,
  }) : super(key: key);

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: widget.favoriteLists.isSelected
              ? Colors.black
              : ColorPath.primarywhite,
          border: Border.all(
              color: widget.favoriteLists.isSelected
                  ? Colors.transparent
                  : Colors.grey),
          borderRadius: BorderRadius.circular(3.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.favoriteLists.isSelected
              ? const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Icon(
                      Icons.check_circle,
                      size: 10,
                      color: Colors.green,
                    )
                  ]),
                )
              : const SizedBox.shrink(),
          const YMargin(5.0),
          SvgPicture.asset(
            widget.favoriteLists.icon,
            color: widget.favoriteLists.isSelected
                ? ColorPath.primaryfield
                : ColorPath.primarydark,
          )
        ],
      ),
    ).ripple(() {
      setState(() {
        widget.onSelected(widget.favoriteLists);
      });
    }));
  }
}

Widget tripdetails(
  String icon,
  String locate,
  String location,
  String extimated,
  String eIcon,
  String eDistance,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(icon),
              ],
            ),
            const XMargin(5),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locate,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: ColorPath.primaryblack.withOpacity(0.5),
                  ),
                ),
                const YMargin(10),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF818181),
                  ),
                )
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              extimated,
              style: const TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.w300,
                color: Color(0xFF818181),
              ),
            ),
            const YMargin(2.0),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorPath.primarydark,
                  borderRadius: BorderRadius.circular(7.0)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    eIcon,
                    height: 16,
                    width: 16,
                  ),
                  const XMargin(4),
                  Text(
                    eDistance,
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      color: ColorPath.primaryfield,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
