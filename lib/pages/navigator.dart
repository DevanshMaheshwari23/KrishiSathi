import 'package:krishi_sathi/pages/homepage.dart';
import 'package:krishi_sathi/pages/predictionpage.dart';
import 'package:krishi_sathi/pages/profilepage.dart';
import 'package:krishi_sathi/services/language_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedPage = 0;
  final pages = [const HomePage(), const PredictionPage(), const ProfilePage()];
  final LanguageService _languageService = LanguageService();

  @override
  void initState() {
    super.initState();
    _languageService.languageChangeNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedPage,
          fixedColor: const Color(0xFF5F8D4E),
          unselectedItemColor: const Color(0xFF757575),
          onTap: (position) {
            setState(() {
              selectedPage = position;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Iconsax.home), label: _languageService.home),
            BottomNavigationBarItem(
                icon: const Icon(Iconsax.health),
                label: _languageService.predict),
            BottomNavigationBarItem(
                icon: const Icon(Iconsax.user), label: _languageService.account)
          ]),
    );
  }
}
