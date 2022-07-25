import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/models/record.dart';
import 'package:shopping_home/screens/wallet/components/record_card.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({Key? key}) : super(key: key); //UNcomment revery comment

  @override
  Widget build(BuildContext context) {
    RecordsScreenArguments arguments = RecordsScreenArguments();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      arguments =
          ModalRoute.of(context)?.settings.arguments as RecordsScreenArguments;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Records".tr),
        ),
      ),
      body: ListView(
        children: [
          ...List.generate(
            arguments.records == null ? 0 : arguments.records!.length,
            (index) => RecordCard(
              press: () => {
                
              },
              balance: arguments.records![index].balance,
              date: arguments.records![index].createdAt,
            ),
          )
        ],
      ),
    );
  }
}

class RecordsScreenArguments {
  List<Record>? records;
  RecordsScreenArguments({this.records});
}
