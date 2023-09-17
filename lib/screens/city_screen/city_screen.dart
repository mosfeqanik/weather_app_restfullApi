import 'package:flutter/material.dart';

import '../../utilies/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  TextEditingController? _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height and width
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black26),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, _textEditingController!.text);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 0.05 * screenHeight, // Adjust the icon size
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(0.04 * screenHeight), // Adjust padding
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter city name",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 0.06 * screenHeight, // Adjust the icon size
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                            0.02 * screenHeight), // Adjust the radius
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      0.03 * screenHeight), // Adjust the radius
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, _textEditingController!.text);
                  },
                  child: const Text(
                    'Get Weather',
                    style: kButtonTextStyle,
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
