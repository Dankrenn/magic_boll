import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MagicBollWidget extends StatefulWidget {
  const MagicBollWidget({Key? key}) : super(key: key);

  @override
  State<MagicBollWidget> createState() => _MagicBollWidgetState();
}

class _MagicBollWidgetState extends State<MagicBollWidget> {
  late String str = '';

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.https('eightballapi.com', 'api'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        setState(() {
          str = jsonData['reading'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                await fetchData();
              },
              child: Image.asset('assets/circle.png'),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Press the ball and make a wish!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
            Text(
              Intl.message(
                str,
                name: 'magicBallPrompt',
                desc: 'Prompt for the magic ball',
                locale: Localizations.localeOf(context).languageCode,
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
