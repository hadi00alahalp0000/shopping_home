// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopping_home/components/coustom_bottom_nav_bar.dart';
import 'package:shopping_home/enums.dart';

import 'components/body.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.wallet),
    );
  }
}
