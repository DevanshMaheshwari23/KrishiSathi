import 'package:flutter/material.dart';

class LanguageService {
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  bool _isEnglish = true;
  final ValueNotifier<bool> languageChangeNotifier = ValueNotifier<bool>(true);

  bool get isEnglish => _isEnglish;

  void setLanguage(bool isEnglish) {
    _isEnglish = isEnglish;
    languageChangeNotifier.value = isEnglish;
  }

  // Common translations
  String get recommendedCrops =>
      _isEnglish ? 'Recommended Crops' : 'अनुशंसित फसलें';
  String get recommendedFertilizers =>
      _isEnglish ? 'Recommended Fertilizers' : 'अनुशंसित उर्वरक';
  String get predictCrop =>
      _isEnglish ? 'Predict Crop' : 'फसल की भविष्यवाणी करें';
  String get home => _isEnglish ? 'Home' : 'होम';
  String get predict => _isEnglish ? 'Predict' : 'भविष्यवाणी';
  String get account => _isEnglish ? 'Account' : 'खाता';
  String get appSettings => _isEnglish ? 'App Settings' : 'ऐप सेटिंग';
  String get selectLanguage => _isEnglish ? 'Select Language' : 'भाषा चुनें';
  String get currentLanguage =>
      _isEnglish ? 'Current Language: English' : 'वर्तमान भाषा: हिंदी';
  String get privacyPolicy => _isEnglish ? 'Privacy Policy' : 'गोपनीयता नीति';
  String get termsAndConditions =>
      _isEnglish ? 'Terms and conditions' : 'नियम और शर्तें';
  String get about => _isEnglish ? 'About' : 'के बारे में';
  String get notifications => _isEnglish ? 'Notifications' : 'सूचनाएं';
  String get yourPredictionIsReady =>
      _isEnglish ? 'Your Prediction Is Ready' : 'आपकी भविष्यवाणी तैयार है';
  String get checkYourPredictedCrop => _isEnglish
      ? 'Check your predicted crop'
      : 'अपनी भविष्यवाणी की गई फसल की जांच करें';
  String get predictedCrop =>
      _isEnglish ? 'Predicted Crop' : 'भविष्यवाणी की गई फसल';
  String get welcomeToKrishiSathi =>
      _isEnglish ? 'Welcome to Krishi Sathi!' : 'कृषि साथी में आपका स्वागत है!';
  String get videoTutorials =>
      _isEnglish ? 'Video Tutorials' : 'वीडियो ट्यूटोरियल';
  String get harvestingTutorials =>
      _isEnglish ? 'Harvesting Tutorials' : 'कटाई ट्यूटोरियल';
  String get learnHowToHarvest => _isEnglish
      ? 'Learn how to harvest your crops'
      : 'अपनी फसल की कटाई कैसे करें यह जानें';
  String get watchTutorial =>
      _isEnglish ? 'Watch Tutorial' : 'ट्यूटोरियल देखें';
  String get pickLocation => _isEnglish ? 'Pick Location' : 'स्थान चुनें';
  String get cancel => _isEnglish ? 'Cancel' : 'रद्द करें';
  String get save => _isEnglish ? 'Save' : 'सहेजें';
  String get city => _isEnglish ? 'City' : 'शहर';

  // Prediction page translations
  String get temperature => _isEnglish ? 'Temperature' : 'तापमान';
  String get humidity => _isEnglish ? 'Humidity' : 'आर्द्रता';
  String get rainfall => _isEnglish ? 'Rainfall' : 'वर्षा';
  String get phValue => _isEnglish ? 'pH Value' : 'पीएच मान';
  String get nitrogen => _isEnglish ? 'Nitrogen' : 'नाइट्रोजन';
  String get phosphorus => _isEnglish ? 'Phosphorus' : 'फास्फोरस';
  String get potassium => _isEnglish ? 'Potassium' : 'पोटेशियम';
  String get cropDuration => _isEnglish ? 'Crop Duration' : 'फसल अवधि';
  String get sowingSession => _isEnglish ? 'Sowing Session' : 'बुवाई सत्र';
  String get predictNow => _isEnglish ? 'Predict Now' : 'अभी भविष्यवाणी करें';
  String get predicting =>
      _isEnglish ? 'Predicting...' : 'भविष्यवाणी कर रहे हैं...';
  String get clickToPredict =>
      _isEnglish ? 'Click to Predict' : 'भविष्यवाणी के लिए क्लिक करें';
  String get rice => _isEnglish ? 'Rice' : 'चावल';
  String get maize => _isEnglish ? 'Maize' : 'मक्का';
  String get chickpea => _isEnglish ? 'Chickpea' : 'चना';
  String get mango => _isEnglish ? 'Mango' : 'आम';
  String get months => _isEnglish ? 'months' : 'महीने';
  String get parameterInputs =>
      _isEnglish ? 'Parameter Inputs' : 'पैरामीटर इनपुट';
  String get soilParameters =>
      _isEnglish ? 'Soil Parameters' : 'मिट्टी के पैरामीटर';
  String get environmentParameters =>
      _isEnglish ? 'Environment Parameters' : 'पर्यावरण पैरामीटर';
  String get prediction => _isEnglish ? 'Prediction' : 'भविष्यवाणी';
}
