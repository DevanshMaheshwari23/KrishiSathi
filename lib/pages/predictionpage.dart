import 'package:krishi_sathi/component/HomeBox.dart';
import 'package:krishi_sathi/component/RoundedBox.dart';
import 'package:krishi_sathi/services/language_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:krishi_sathi/services/crop_predictor.dart';

// Define app theme colors based on Krishi Sathi logo
class AppColors {
  static const Color primaryGreen = Color(0xFF5F8D4E);
  static const Color secondaryBrown = Color(0xFF8B4513);
  static const Color lightGreen = Color(0xFFCFE8A9);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  var predValur = "";
  bool isLoading = false;
  bool useLocalPrediction = true; // Set to true to avoid API dependency
  final LanguageService _languageService = LanguageService();

  // Controllers for input fields with more varied default values
  final TextEditingController nitrogenController =
      TextEditingController(text: "40");
  final TextEditingController potassiumController =
      TextEditingController(text: "60");
  final TextEditingController phosphorusController =
      TextEditingController(text: "50");
  final TextEditingController phValueController =
      TextEditingController(text: "7.1");
  final TextEditingController temperatureController =
      TextEditingController(text: "20");
  final TextEditingController humidityController =
      TextEditingController(text: "50");
  final TextEditingController rainfallController =
      TextEditingController(text: "60");
  final TextEditingController cropDurationController =
      TextEditingController(text: "4");
  final TextEditingController sowingSessionController =
      TextEditingController(text: "1");

  // Real-time values for dynamic widgets
  double _temperature = 20.0;
  double _humidity = 50.0;
  double _rainfall = 60.0;
  double _phValue = 7.1;

  // Define the crop classes
  List<String> cropClasses = [
    'rice',
    'maize',
    'chickpea',
    'kidneybeans',
    'pigeonpeas',
    'mothbeans',
    'mungbean',
    'blackgram',
    'lentil',
    'pomegranate',
    'banana',
    'mango',
    'grapes',
    'watermelon',
    'muskmelon',
    'apple',
    'orange',
    'papaya',
    'coconut'
  ];

  // Prediction server URL
  final String predictionServerUrl =
      "http://10.0.2.2:5000"; // For Android emulator

  @override
  void initState() {
    super.initState();
    predValur = _languageService.clickToPredict;

    _languageService.languageChangeNotifier.addListener(() {
      setState(() {
        predValur = _getPredictionText(predValur);
      });
    });

    // Run validation tests to verify the prediction algorithm
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Run validation tests in the background
      CropPredictor.validateWithExamples();

      // Pre-populate a prediction
      _predictWithCurrentValues();
    });
  }

  String _getPredictionText(String currentValue) {
    if (currentValue == "Click to Predict" ||
        currentValue == "भविष्यवाणी के लिए क्लिक करें") {
      return _languageService.clickToPredict;
    } else if (currentValue == "Predicting..." ||
        currentValue == "भविष्यवाणी कर रहे हैं...") {
      return _languageService.predicting;
    }
    return currentValue;
  }

  // Update dynamic values whenever text fields change
  void _updateDynamicValues() {
    setState(() {
      _temperature =
          double.tryParse(temperatureController.text) ?? _temperature;
      _humidity = double.tryParse(humidityController.text) ?? _humidity;
      _rainfall = double.tryParse(rainfallController.text) ?? _rainfall;
      _phValue = double.tryParse(phValueController.text) ?? _phValue;
    });
  }

  // Helper method to predict with current values
  void _predictWithCurrentValues() {
    try {
      double n = double.tryParse(nitrogenController.text) ?? 0;
      double p = double.tryParse(potassiumController.text) ?? 0;
      double k = double.tryParse(phosphorusController.text) ?? 0;
      double temperature = double.tryParse(temperatureController.text) ?? 0;
      double humidity = double.tryParse(humidityController.text) ?? 0;
      double ph = double.tryParse(phValueController.text) ?? 0;
      double rainfall = double.tryParse(rainfallController.text) ?? 0;
      double durationmonths = double.tryParse(cropDurationController.text) ?? 0;
      double period = double.tryParse(sowingSessionController.text) ?? 0;

      // Update the dynamic values
      _updateDynamicValues();

      String prediction = CropPredictor.predictCrop(
        n: n,
        p: p,
        k: k,
        temperature: temperature,
        humidity: humidity,
        ph: ph,
        rainfall: rainfall,
        durationmonths: durationmonths,
        period: period,
      );

      setState(() {
        predValur = prediction;
      });
    } catch (e) {
      print('Error in initial prediction: $e');
    }
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    nitrogenController.dispose();
    potassiumController.dispose();
    phosphorusController.dispose();
    phValueController.dispose();
    temperatureController.dispose();
    humidityController.dispose();
    rainfallController.dispose();
    cropDurationController.dispose();
    sowingSessionController.dispose();
    super.dispose();
  }

  // Method to make the prediction using API
  Future<void> predData() async {
    if (kIsWeb) {
      // For web platform, use a mock response
      _handleWebPrediction();
    } else {
      setState(() {
        isLoading = true;
        predValur = _languageService.predicting;
      });

      try {
        // Parse input values from text fields
        double n = double.tryParse(nitrogenController.text) ?? 0;
        double p = double.tryParse(potassiumController.text) ?? 0;
        double k = double.tryParse(phosphorusController.text) ?? 0;
        double temperature = double.tryParse(temperatureController.text) ?? 0;
        double humidity = double.tryParse(humidityController.text) ?? 0;
        double ph = double.tryParse(phValueController.text) ?? 0;
        double rainfall = double.tryParse(rainfallController.text) ?? 0;
        double durationmonths =
            double.tryParse(cropDurationController.text) ?? 0;
        double period = double.tryParse(sowingSessionController.text) ?? 0;

        // Update dynamic values
        _updateDynamicValues();

        String prediction = "";

        if (useLocalPrediction) {
          // Use the local prediction algorithm
          prediction = CropPredictor.predictCrop(
            n: n,
            p: p,
            k: k,
            temperature: temperature,
            humidity: humidity,
            ph: ph,
            rainfall: rainfall,
            durationmonths: durationmonths,
            period: period,
          );

          print('Predicted crop using local algorithm: $prediction');
        } else {
          // Use server prediction if local fails
          prediction = CropPredictor.predictCrop(
            n: n,
            p: p,
            k: k,
            temperature: temperature,
            humidity: humidity,
            ph: ph,
            rainfall: rainfall,
            durationmonths: durationmonths,
            period: period,
          );
        }

        setState(() {
          predValur = prediction;
          isLoading = false;
        });
      } catch (e) {
        print('Error in prediction process: $e');
        setState(() {
          predValur = "Error in prediction";
          isLoading = false;
        });
      }
    }
  }

  void _handleWebPrediction() {
    // Mock response for web
    setState(() {
      predValur = "Rice"; // Mock prediction result for web
    });
  }

  // Presets for different crops
  void _applyPreset(String crop) {
    switch (crop) {
      case 'rice':
        nitrogenController.text = "80";
        potassiumController.text = "40";
        phosphorusController.text = "40";
        temperatureController.text = "23.5";
        humidityController.text = "82";
        phValueController.text = "6.5";
        rainfallController.text = "200";
        cropDurationController.text = "4";
        break;
      case 'maize':
        nitrogenController.text = "90";
        potassiumController.text = "42";
        phosphorusController.text = "43";
        temperatureController.text = "26";
        humidityController.text = "52";
        phValueController.text = "7.0";
        rainfallController.text = "88";
        cropDurationController.text = "5";
        break;
      case 'chickpea':
        nitrogenController.text = "40";
        potassiumController.text = "60";
        phosphorusController.text = "50";
        temperatureController.text = "19";
        humidityController.text = "50";
        phValueController.text = "7.1";
        rainfallController.text = "60";
        cropDurationController.text = "4";
        break;
      case 'mango':
        nitrogenController.text = "20";
        potassiumController.text = "30";
        phosphorusController.text = "40";
        temperatureController.text = "30";
        humidityController.text = "70";
        phValueController.text = "6.1";
        rainfallController.text = "80";
        cropDurationController.text = "8";
        break;
      default:
        break;
    }

    // Predict after setting values
    _predictWithCurrentValues();
  }

  // Custom widget for parameter displays
  Widget _buildParameterWidget(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryGreen, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreen.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryGreen, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.secondaryBrown,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  // Custom input field with better styling
  Widget _buildInputField(String label, TextEditingController controller,
      {String? suffix, double? min, double? max}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.secondaryBrown),
          suffixText: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryGreen),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.primaryGreen, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: (value) {
          if (controller == temperatureController ||
              controller == humidityController ||
              controller == rainfallController ||
              controller == phValueController) {
            _updateDynamicValues();
          }

          // Validate min/max if provided
          if (min != null || max != null) {
            double? numValue = double.tryParse(value);
            if (numValue != null) {
              if (min != null && numValue < min) {
                controller.text = min.toString();
              } else if (max != null && numValue > max) {
                controller.text = max.toString();
              }
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryGreen,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.white),
          onPressed: () {
            // Handle menu button press
          },
        ),
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
              RoundedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        _languageService.environmentParameters,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryBrown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Dynamic parameter widgets in a grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.9,
                      children: [
                        _buildParameterWidget(
                          _languageService.temperature,
                          '${_temperature.toStringAsFixed(1)}°C',
                          Icons.thermostat,
                        ),
                        _buildParameterWidget(
                          _languageService.humidity,
                          '${_humidity.toStringAsFixed(0)}%',
                          Icons.water_drop,
                        ),
                        _buildParameterWidget(
                          _languageService.rainfall,
                          '${_rainfall.toStringAsFixed(1)}mm',
                          Icons.cloudy_snowing,
                        ),
                        _buildParameterWidget(
                          _languageService.phValue,
                          _phValue.toStringAsFixed(1),
                          Icons.science,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Quick preset buttons
                    Center(
                      child: Text(
                        _languageService.isEnglish
                            ? "Quick Presets"
                            : "त्वरित प्रिसेट",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryBrown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: () => _applyPreset('rice'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: Text(_languageService.rice,
                              style: const TextStyle(fontSize: 14)),
                        ),
                        ElevatedButton(
                          onPressed: () => _applyPreset('maize'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: Text(_languageService.maize,
                              style: const TextStyle(fontSize: 14)),
                        ),
                        ElevatedButton(
                          onPressed: () => _applyPreset('chickpea'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: Text(_languageService.chickpea,
                              style: const TextStyle(fontSize: 14)),
                        ),
                        ElevatedButton(
                          onPressed: () => _applyPreset('mango'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: Text(_languageService.mango,
                              style: const TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              RoundedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        _languageService.soilParameters,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryBrown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                        _languageService.nitrogen, nitrogenController,
                        suffix: "kg/ha", min: 0, max: 140),
                    _buildInputField(
                        _languageService.phosphorus, phosphorusController,
                        suffix: "kg/ha", min: 0, max: 140),
                    _buildInputField(
                        _languageService.potassium, potassiumController,
                        suffix: "kg/ha", min: 0, max: 140),
                    _buildInputField(
                        _languageService.temperature, temperatureController,
                        suffix: "°C", min: 0, max: 50),
                    _buildInputField(
                        _languageService.humidity, humidityController,
                        suffix: "%", min: 0, max: 100),
                    _buildInputField(
                        _languageService.rainfall, rainfallController,
                        suffix: "mm", min: 0, max: 300),
                    _buildInputField(
                        _languageService.phValue, phValueController,
                        min: 0, max: 14),
                    _buildInputField(
                        _languageService.cropDuration, cropDurationController,
                        suffix: _languageService.months, min: 1, max: 12),
                    _buildInputField(
                        _languageService.sowingSession, sowingSessionController,
                        min: 1, max: 12),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              RoundedBox(
                child: Column(
                  children: [
                    Text(
                      _languageService.prediction,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryBrown,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primaryGreen),
                      ),
                      child: Column(
                        children: [
                          Text(
                            predValur,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryGreen,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : predData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: AppColors.white,
                          disabledBackgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white),
                              )
                            : Text(
                                _languageService.predictNow,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
