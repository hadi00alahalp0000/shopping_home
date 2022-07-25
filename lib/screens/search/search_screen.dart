import 'package:flutter/material.dart';
import 'package:shopping_home/screens/search/components/body.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = "/search";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
