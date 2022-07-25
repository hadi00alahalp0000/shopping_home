import 'package:flutter/material.dart';
import 'package:shopping_home/models/review.dart';
import 'package:shopping_home/models/show_products.dart';
import 'package:shopping_home/screens/review/components/body.dart';

class ReviewScreen extends StatelessWidget {
  static String routeName = "/review";
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReviewsArguments arguments = ReviewsArguments();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      arguments =
          ModalRoute.of(context)?.settings.arguments as ReviewsArguments;
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      body: Body(reviews: arguments.reviews!, product: arguments.product!),
    );
  }
}

class ReviewsArguments {
  final List<Review>? reviews;
  final ShowProducts? product;
  ReviewsArguments({this.reviews, this.product});
}
