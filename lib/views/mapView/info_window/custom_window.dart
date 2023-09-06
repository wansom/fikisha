import 'package:fikisha/utils/info_windows.dart';
import 'package:flutter/material.dart';
import 'package:fikisha/utils/colors.dart';

class CustomWindow extends StatelessWidget {
  const CustomWindow({Key? key, required this.info}) : super(key: key);
  final RideInfoWindow info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: ColorPath.primarywhite,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const[
                  BoxShadow(
                      color: Colors.black, spreadRadius: 2, blurRadius: 5),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
              child: Row(
                children: [
                  if (info.type == InfoWindowType.position)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      color: Colors.black,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${(info.time!.inMinutes) % 60}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: ColorPath.primarywhite)),
                          Text('min',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: ColorPath.primarywhite)),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                        child: Text(
                      '${info.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.black),
                    )),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.black),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
