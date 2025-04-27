import 'package:krishi_sathi/component/PredicationBox.dart';
import 'package:krishi_sathi/component/UserAndLocation.dart';
import 'package:krishi_sathi/component/carousel.dart';
import 'package:krishi_sathi/pages/predictionpage.dart';
import 'package:krishi_sathi/services/language_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LanguageService _languageService = LanguageService();

  // List of video tutorials
  final List<VideoTutorial> _tutorials = [
    VideoTutorial(
      title: 'Rice Harvesting Techniques',
      description:
          'Learn how to harvest rice efficiently with modern techniques',
      thumbnailAsset: 'assets/appbarlogo.png',
      durationMinutes: 12,
      cropType: 'rice',
    ),
    VideoTutorial(
      title: 'Maize Harvesting Guide',
      description: 'Step-by-step guide to harvesting maize with minimal loss',
      thumbnailAsset: 'assets/appbarlogo.png',
      durationMinutes: 15,
      cropType: 'maize',
    ),
    VideoTutorial(
      title: 'Mango Harvesting Best Practices',
      description: 'Best practices for harvesting mangoes at the right time',
      thumbnailAsset: 'assets/appbarlogo.png',
      durationMinutes: 10,
      cropType: 'mango',
    ),
    VideoTutorial(
      title: 'Wheat Harvesting 101',
      description: 'The basics of wheat harvesting for beginners',
      thumbnailAsset: 'assets/appbarlogo.png',
      durationMinutes: 8,
      cropType: 'wheat',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _languageService.languageChangeNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: AppColors.primaryGreen,
        centerTitle: true,
        title: Image.asset(
          'assets/appbarlogo.png',
          height: 45, // Increased logo size
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselWithDotsPage(imgList: const [
              'assets/1.png',
              'assets/2.png',
              'assets/3.png',
            ]),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UserAndLocation(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Switch to prediction tab
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PredictionPage(),
                        ),
                      );
                    },
                    child: const PredicationBox(),
                  ),
                  const SizedBox(height: 30),
                  // Video Tutorials Section
                  Text(
                    _languageService.harvestingTutorials,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _languageService.learnHowToHarvest,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _tutorials.length,
                    itemBuilder: (context, index) {
                      final tutorial = _tutorials[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: VideoTutorialCard(
                          tutorial: tutorial,
                          languageService: _languageService,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoTutorial {
  final String title;
  final String description;
  final String thumbnailAsset;
  final int durationMinutes;
  final String cropType;

  VideoTutorial({
    required this.title,
    required this.description,
    required this.thumbnailAsset,
    required this.durationMinutes,
    required this.cropType,
  });

  String getTranslatedTitle(bool isEnglish) {
    if (isEnglish) return title;

    // Hindi translations of titles
    switch (cropType) {
      case 'rice':
        return 'चावल की कटाई तकनीकें';
      case 'maize':
        return 'मक्का कटाई गाइड';
      case 'mango':
        return 'आम की कटाई के सर्वोत्तम तरीके';
      case 'wheat':
        return 'गेहूं की कटाई 101';
      default:
        return title;
    }
  }

  String getTranslatedDescription(bool isEnglish) {
    if (isEnglish) return description;

    // Hindi translations of descriptions
    switch (cropType) {
      case 'rice':
        return 'आधुनिक तकनीकों के साथ कुशलतापूर्वक चावल की कटाई करना सीखें';
      case 'maize':
        return 'न्यूनतम नुकसान के साथ मक्का की कटाई के लिए चरण-दर-चरण गाइड';
      case 'mango':
        return 'सही समय पर आम की कटाई के लिए सर्वोत्तम प्रथाएं';
      case 'wheat':
        return 'शुरुआती लोगों के लिए गेहूं की कटाई की मूल बातें';
      default:
        return description;
    }
  }
}

class VideoTutorialCard extends StatelessWidget {
  final VideoTutorial tutorial;
  final LanguageService languageService;

  const VideoTutorialCard({
    super.key,
    required this.tutorial,
    required this.languageService,
  });

  void _showVideoPlayer(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(tutorial.thumbnailAsset),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutorial.getTranslatedTitle(languageService.isEnglish),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tutorial
                          .getTranslatedDescription(languageService.isEnglish),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${languageService.isEnglish ? "Duration" : "अवधि"}: ${tutorial.durationMinutes} ${languageService.isEnglish ? "minutes" : "मिनट"}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showVideoPlayer(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: AppColors.lightGreen,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video thumbnail
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(tutorial.thumbnailAsset),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${tutorial.durationMinutes}:00',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Video info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tutorial.getTranslatedTitle(languageService.isEnglish),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.secondaryBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tutorial
                        .getTranslatedDescription(languageService.isEnglish),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showVideoPlayer(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Iconsax.video),
                      label: Text(languageService.watchTutorial),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
