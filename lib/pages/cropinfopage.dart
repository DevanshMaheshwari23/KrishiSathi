import 'package:krishi_sathi/component/RoundedBox.dart';
import 'package:krishi_sathi/services/language_service.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CropInfoPage extends StatelessWidget {
  const CropInfoPage({super.key});

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
          const RoundedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wheat",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Wheat is typically milled into flour which is then used to make a wide range of foods including bread, crumpets, muffins, noodles, pasta, biscuits, cakes, pastries, cereal bars, sweet and savoury snack foods, crackers, crisp-breads, sauces and confectionery (e.g. liquorice).",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
            ],
          )),
          const Text(
            "Recommended Fertilisers",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ).p16(),
          const SimpleFertilizersList(),
        ]).p16(),
      ),
    );
  }
}

// Simplified replacement for RecommandedFertilisers
class SimpleFertilizersList extends StatelessWidget {
  const SimpleFertilizersList({super.key});

  @override
  Widget build(BuildContext context) {
    final fertilizers = [
      {"name": "NPK", "image": "assets/appbarlogo.png"},
      {"name": "Urea", "image": "assets/appbarlogo.png"},
      {"name": "Phosphorus", "image": "assets/appbarlogo.png"},
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: fertilizers.length,
        itemBuilder: (context, index) {
          final fertilizer = fertilizers[index];
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
                      fertilizer["image"]!,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fertilizer["name"]!,
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
