import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'price.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<dynamic>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _fetchNews();
  }

  Future<void> _refreshNews() async {
    setState(() {
      _newsFuture = _fetchNews();
    });
  }

  Future<List<dynamic>> _fetchNews() async {
    final headers = <String, String>{'my_header_key': 'my_header_value'};
    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=0f4f0863fd5845ea80a13efc4eb4e7cc',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffB3B3B7),
      appBar: AppBar(
        title: const Text(
          'Kryyptonium',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xffB3B3B7),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: _refreshNews,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final article = snapshot.data![index];
                        return GestureDetector(
                          onTap: () async {
                            final url = article['url'];
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                              );
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: article['urlToImage'] != null &&
                                          Uri.parse(article['urlToImage'])
                                              .isAbsolute
                                      ? FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/Placeholder.png',
                                          image:
                                              Uri.parse(article['urlToImage'])
                                                  .toString(),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/Placeholder.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    article['title'],
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    article['description'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Price()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7C5AF1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50), // Change the shape to a circle
                      ),
                      elevation:
                          10, // Add some elevation to give the button a 3D look
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical:
                              20), // Increase the padding to make the button larger
                    ),
                    child: const Text(
                      'Go to Crypto Tracker',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w900,
                        color: Colors
                            .white, // Change the text color to white to contrast with the background color
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Text('${snapshot.error}'),
                const SizedBox(
                  height: 300,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Price()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7C5AF1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50), // Change the shape to a circle
                      ),
                      elevation:
                      10, // Add some elevation to give the button a 3D look
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical:
                          20), // Increase the padding to make the button larger
                    ),
                    child: const Text(
                      'Go to Crypto Tracker',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w900,
                        color: Colors
                            .white, // Change the text color to white to contrast with the background color
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
