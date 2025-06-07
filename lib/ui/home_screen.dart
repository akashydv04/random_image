import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  var image_url = "";

  void fetchRandomImage() async {
    final response = await dio.get('https://dog.ceo/api/breeds/image/random');
    try {
      if (response.data['status'] == "success") {
        setState(() {
          image_url = response.data['message'];
        });
        print(response.data['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomImage(); // Fetch image when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Image', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[800],
      ),
      backgroundColor: Colors.deepPurple[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image_url == ""
                ? CircularProgressIndicator()
                : Image(
                    image: NetworkImage(image_url),
                    fit: BoxFit.cover,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                  ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                fetchRandomImage();
              },
              child: Text(
                "Fetch Random Image",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
