import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("TMDB"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Now Playing",
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CarouselSlider.builder(
                    itemCount: 20,
                    itemBuilder: (context, itemIndex, pageViewIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 300,
                          width: 200,
                          color: Colors.red,
                          child: Text(
                            itemIndex.toString(),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 300,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.55,
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
