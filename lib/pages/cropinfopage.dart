import 'package:agrigenie/component/RoundedBox.dart';
import 'package:agrigenie/data/cropdata.dart';
import 'package:agrigenie/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CropInfoPage extends StatelessWidget {
  CropInfoPage({Key? key});

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
          height: 30,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
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
                image: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/a/a3/Vehn%C3%A4pelto_6.jpg"),
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
          Text(
            "Recommended Fertilisers",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ).p16(),
          const RecommandedFertilisers(),
        ]).p16(),
      ),
    );
  }
}
