import 'package:flutter/material.dart';
import 'news.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the NewsPage after a delay
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NewsPage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xff657F95),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff657F95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/aoo_icon-modified.png', // replace this with your app icon path
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Kryyptonium',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 70),
                      const Text(
                        'Stay up-to-date with the latest news and trends',
                        style: TextStyle(
                          fontFamily: 'EduNSWACT',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                const Text(
                  'Powered by Kryptonite',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
