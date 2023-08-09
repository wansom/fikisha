import 'package:fikisha/utils/colors.dart';
import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/utils/splash_tiles.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'package:fikisha/views/Home/Components/rydr_drawer.dart';
import 'package:fikisha/views/Home/receive_package_view.dart';
import 'package:fikisha/views/Home/send_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:location/location.dart'  as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryOnboardingScreen extends StatefulWidget {
  const DeliveryOnboardingScreen({super.key});

  @override
  State<DeliveryOnboardingScreen> createState() => _DeliveryOnboardingScreenState();
}

class _DeliveryOnboardingScreenState extends State<DeliveryOnboardingScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final PageController pageController;
  late int selectedPage;
  late GoogleMapController controller;
  loc.LocationData? currentLocation;

    @override
    void initState() {
    super.initState();
    selectedPage = 0;
    pageController = PageController(initialPage: selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    const pageCount = 3;
    return Scaffold(
      key: _key,
      drawer: const RyderDrawer(),
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
                  'Get your package delivered now',
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
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
              child: PageView(
            controller: pageController,
            onPageChanged: (page) {
              setState(() {
                selectedPage = page;
              });
            },
            children: DataConstants.onboardingTiles,
            ),            
            ),            
            PageViewDotIndicator(
            count: pageCount,
            currentItem: selectedPage,
            selectedColor: Colors.black,
            unselectedColor: Colors.grey,
            ),
            const Spacer(),
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sendPackageButton(context),
              const SizedBox(height: 7,),
              receivePackageButton(context),
                        ],
                      ),
              ],
            ),
          ),
    );
  }
    ElevatedButton receivePackageButton(BuildContext context) {
    return ElevatedButton(
                    onPressed: () {                      
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ReceivePackageView())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width , 60),
                      backgroundColor: Colors.grey[350],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ), 
                    child: const Text(
                      'Receive a package now',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),
                    ),
                    );
  }
   
ElevatedButton sendPackageButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width, 60),
      backgroundColor: ColorPath.primaryblack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SendPackageView())
      );
    },
    child: const Text(
      'Send a package now',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    ),
  );
}
}