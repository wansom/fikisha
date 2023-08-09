import 'package:fikisha/utils/images_path.dart';
import 'package:fikisha/views/Home/Components/onboarding_tile.dart';

class DataConstants {
  static final onboardingTiles = [
     OnboardingTile(
      description: 'Get your forgotten package in minutes',
      image: ImagesAsset.illustration1,
      title: 'Forgot something?',
    ),
     OnboardingTile(
      description: 'Need to surprise someone??',
      image: ImagesAsset.illustration2,
      title: 'Gift your loved ones and friends',
    ),
    OnboardingTile(
      title: 'Got any supplies to deliver??',
      description: 'Anything from well packaged shopping to spare parts',
      image: ImagesAsset.illustration3,
    )
  ];
}