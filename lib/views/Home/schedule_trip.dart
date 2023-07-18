// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fikisha/utils/margins.dart';
import 'package:fikisha/views/Home/Components/home_extention.dart';
import 'Components/sheet_header.dart';
import 'package:fikisha/utils/colors.dart';
import 'build_trip_details.dart';

scheduleTrip(BuildContext context) {
  showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return const ScheduleTrip();
      });
}

class ScheduleTrip extends StatefulWidget {
  const ScheduleTrip({Key? key}) : super(key: key);

  @override
  _ScheduleTripState createState() => _ScheduleTripState();
}

class _ScheduleTripState extends State<ScheduleTrip> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 7),
        height: context.screenHeight() / 3,
        width: context.screenWidth(),
        decoration: const BoxDecoration(
          color: ColorPath.primarywhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(children: [
          sheetHeader(),
          const YMargin(15),
          const Text(
        "Schedule a Delivery",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: ColorPath.primarydark,
        ),
          ),
          const Text(
        "Book a ride for later?",
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
          const YMargin(20),
          const Column(
            children: [
              Text(
                "Date",
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w300,
                  color: ColorPath.offBlack,
                ),
              ),
              YMargin(10),
              Text(
                "Mon, 10 June, 2021",
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: ColorPath.primaryColor,
                ),
              ),
              YMargin(10),
              DotWidget(
                dashColor: ColorPath.primaryfield,
                dashHeight: 1.0,
                dashWidth: 2.0,
              ),
            ],
          ).ripple(() async {
        final initialDate = DateTime.now();
        await showDatePicker(
          context: context,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ColorPath.primarydark,
                  onPrimary: ColorPath.primarywhite,
                  onSurface: ColorPath.primarydark,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: ColorPath.primaryColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
          initialDate: initialDate,
          firstDate: DateTime(DateTime.now().year - 80),
          lastDate: DateTime(DateTime.now().year + 1),
        );
          }),
          const YMargin(15),
          const Column(
        children: [
          Text(
            "Time",
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w300,
              color: ColorPath.offBlack,
            ),
          ),
          YMargin(10),
          Text(
            "09 : 00 pm",
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: ColorPath.primaryColor,
            ),
          ),
          YMargin(10),
          DotWidget(
            dashColor: ColorPath.primaryfield,
            dashHeight: 1.0,
            dashWidth: 2.0,
          ),
        ],
          ).ripple(() async {
        final initialDate = TimeOfDay.now();
        await showTimePicker(
          initialTime: initialDate,
          context: context,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ColorPath.primarydark,
                  onPrimary: ColorPath.primarywhite,
                  onSurface: ColorPath.primarydark,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: ColorPath.primaryColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
          }),
        ]));
  }
}
