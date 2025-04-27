import 'package:krishi_sathi/firebase_options.dart';
import 'package:krishi_sathi/pages/cropinfopage.dart';
import 'package:krishi_sathi/pages/fertilizerinfopage.dart';
import 'package:krishi_sathi/pages/navigator.dart';
import 'package:krishi_sathi/pages/notificationpage.dart';
import 'package:krishi_sathi/services/language_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _languageService = LanguageService();

  @override
  void initState() {
    super.initState();
    _languageService.languageChangeNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _languageService.languageChangeNotifier.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krishi Sathi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5F8D4E),
          primary: const Color(0xFF5F8D4E),
          secondary: const Color(0xFF8B4513),
        ),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
      routes: {
        '/cropInfo': (context) => const CropInfoPage(),
        '/fertilizerInfo': (context) => const FertilizerInfoPage(),
        '/notifications': (context) => const NotificationPage(),
      },
    );
  }
}
