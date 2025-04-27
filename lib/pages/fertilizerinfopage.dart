import 'package:krishi_sathi/component/RoundedBox.dart';
import 'package:krishi_sathi/services/language_service.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FertilizerInfoPage extends StatelessWidget {
  const FertilizerInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final CropDescription? crop =
    //     ModalRoute.of(context)?.settings.arguments as CropDescription?;
    // if (crop == null) {
    //   // Handle the case where crop is null
    //   return Scaffold(
    //     body: Center(
    //       child: Text('Crop information not available.'),
    //     ),
    //   );
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Handle menu button press
          },
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/appbarlogo.png', // Replace with your logo image path
          height: 45,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: VStack([
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/appbarlogo.png'),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  offset: const Offset(16, 16),
                  blurRadius: 40,
                ),
              ],
              border: Border.all(
                width: 1,
                color: const Color(0xff14FF00),
              ),
              borderRadius: BorderRadius.circular(11),
            ),
          ),
          const SizedBox(height: 20),
          RoundedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "NPK",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "NPK fertilizer is a type of fertilizer that contains three primary nutrients: nitrogen (N), phosphorus (P), and potassium (K). It is commonly used in agricultural practices to promote plant growth and improve crop yield.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff00A45F),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          )),
          const Text(
            "Recommended Crops",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ).p16(),
          const SimpleCropsList(),
        ]).p16(),
      ),
    );
  }
}

// Simplified replacement for RecommandedCrop
class SimpleCropsList extends StatelessWidget {
  const SimpleCropsList({super.key});

  @override
  Widget build(BuildContext context) {
    final crops = [
      {"name": "Wheat", "image": "assets/appbarlogo.png"},
      {"name": "Rice", "image": "assets/appbarlogo.png"},
      {"name": "Maize", "image": "assets/appbarlogo.png"},
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: crops.length,
        itemBuilder: (context, index) {
          final crop = crops[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xff14FF00)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      crop["image"]!,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    crop["name"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
