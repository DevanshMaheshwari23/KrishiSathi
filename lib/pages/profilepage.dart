import 'package:krishi_sathi/component/RoundedBox.dart';
import 'package:krishi_sathi/pages/notificationpage.dart';
import 'package:krishi_sathi/pages/privacypolicy.dart';
import 'package:krishi_sathi/pages/termsandcondition.dart';
import 'package:krishi_sathi/pages/predictionpage.dart';
import 'package:krishi_sathi/services/language_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // For language selection - get from language service
  final LanguageService _languageService = LanguageService();

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
          height: 30,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Language selection box
              RoundedBox(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        _languageService.appSettings,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryBrown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      _languageService.selectLanguage,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryBrown,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // English option
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _languageService.setLanguage(true);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: _languageService.isEnglish
                                  ? AppColors.primaryGreen
                                  : AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.primaryGreen,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'English',
                              style: TextStyle(
                                color: _languageService.isEnglish
                                    ? AppColors.white
                                    : AppColors.primaryGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        // Hindi option
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _languageService.setLanguage(false);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: !_languageService.isEnglish
                                  ? AppColors.primaryGreen
                                  : AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.primaryGreen,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'हिंदी',
                              style: TextStyle(
                                color: !_languageService.isEnglish
                                    ? AppColors.white
                                    : AppColors.primaryGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Language status text
                    Center(
                      child: Text(
                        _languageService.currentLanguage,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.secondaryBrown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Information section
              RoundedBox(
                child: Column(
                  children: [
                    // Privacy Policy
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyPage(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(
                          Iconsax.shield,
                          color: AppColors.secondaryBrown,
                        ),
                        title: Text(
                          _languageService.privacyPolicy,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.secondaryBrown,
                          ),
                        ),
                      ),
                    ),
                    // Terms and conditions
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TermsAndConditionsPage(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(
                          Iconsax.security_user,
                          color: AppColors.secondaryBrown,
                        ),
                        title: Text(
                          _languageService.termsAndConditions,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.secondaryBrown,
                          ),
                        ),
                      ),
                    ),
                    // About the app
                    GestureDetector(
                      onTap: () {
                        // Show About Dialog
                        showAboutDialog(
                          context: context,
                          applicationName: 'Krishi Sathi',
                          applicationVersion: '1.0.0',
                          applicationIcon: Image.asset(
                            'assets/appbarlogo.png',
                            height: 50,
                            width: 50,
                          ),
                          applicationLegalese: '© 2023 Krishi Sathi',
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              _languageService.isEnglish
                                  ? 'Krishi Sathi is an application designed to help farmers predict suitable crops for their land based on soil and environmental conditions.'
                                  : 'कृषि साथी एक ऐसा एप्लिकेशन है जो किसानों को मिट्टी और पर्यावरणीय स्थितियों के आधार पर उनकी भूमि के लिए उपयुक्त फसलों की भविष्यवाणी करने में मदद करने के लिए डिज़ाइन किया गया है।',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        );
                      },
                      child: ListTile(
                        leading: const Icon(
                          Iconsax.info_circle,
                          color: AppColors.secondaryBrown,
                        ),
                        title: Text(
                          _languageService.about,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.secondaryBrown,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
