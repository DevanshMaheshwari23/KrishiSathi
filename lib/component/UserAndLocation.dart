import 'package:flutter/material.dart';
import 'package:krishi_sathi/pages/predictionpage.dart';
import 'package:krishi_sathi/services/language_service.dart';

class UserAndLocation extends StatefulWidget {
  const UserAndLocation({
    super.key,
  });

  @override
  State<UserAndLocation> createState() => _UserAndLocationState();
}

class _UserAndLocationState extends State<UserAndLocation> {
  final LanguageService _languageService = LanguageService();
  String _currentLocation = "Nagpur";

  // Function to show location picker dialog
  void _showLocationPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String tempLocation = _currentLocation;

        return AlertDialog(
          title: Text(
            _languageService.isEnglish ? "Pick Location" : "स्थान चुनें",
            style: const TextStyle(
              color: AppColors.secondaryBrown,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Show a mock map image
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/appbarlogo.png'),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.primaryGreen,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Location selection dropdown
                DropdownButtonFormField<String>(
                  value: tempLocation,
                  decoration: InputDecoration(
                    labelText: _languageService.isEnglish ? "City" : "शहर",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: [
                    "Nagpur",
                    "Mumbai",
                    "Delhi",
                    "Bangalore",
                    "Chennai",
                    "Kolkata",
                    "Hyderabad",
                    "Pune",
                    "Ahmedabad",
                    "Jaipur"
                  ].map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      tempLocation = newValue;
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                _languageService.isEnglish ? "Cancel" : "रद्द करें",
                style: const TextStyle(color: AppColors.secondaryBrown),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentLocation = tempLocation;
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
              ),
              child: Text(
                _languageService.isEnglish ? "Save" : "सहेजें",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _languageService.isEnglish
              ? "Welcome to\nKrishi Sathi!"
              : "कृषि साथी में\nआपका स्वागत है!",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryBrown,
          ),
        ),
        GestureDetector(
          onTap: _showLocationPicker,
          child: Container(
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.lightGreen),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 20,
                    color: AppColors.secondaryBrown,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _currentLocation,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryBrown,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.secondaryBrown,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
