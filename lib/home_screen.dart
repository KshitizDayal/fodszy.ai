import 'package:flutter/material.dart';
import 'package:fodzsy_ai/screens/amazon.dart';
import 'package:fodzsy_ai/screens/bigbasket.dart';
import 'package:fodzsy_ai/screens/blinkit.dart';
import 'package:fodzsy_ai/screens/flipkart.dart';
import 'package:fodzsy_ai/screens/tata1mg.dart';
import 'package:fodzsy_ai/screens/zepto.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/Fodzsy.AI.png",
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Try out the new AI assistant for the apps!",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    "Supported Apps",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  imageColumn(
                    imageUrl: "assets/images/flipkart.png",
                    text: "Flipkart",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Flipkart()));
                    },
                  ),
                  imageColumn(
                    imageUrl: "assets/images/blinkit.jpg",
                    text: "Blinkit",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Blinkit()));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  imageColumn(
                    imageUrl: "assets/images/zepto.jpeg",
                    text: "Zepto",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Zepto()));
                    },
                  ),
                  imageColumn(
                    imageUrl: "assets/images/tata1mg.png",
                    text: "Tata 1mg",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Tata1mg(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  imageColumn(
                    imageUrl: "assets/images/amazon.png",
                    text: "Amazon",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Amazon()));
                    },
                  ),
                  imageColumn(
                    imageUrl: "assets/images/bigbasket.jpeg",
                    text: "BigBasket",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BigBasket(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageColumn({
    required String imageUrl,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.asset(
                imageUrl,
                height: 100,
                width: 100,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
