// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:shopping_home/models/show_products.dart';
import '../../../const_server.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ShowProducts product;

  @override
  ProductImagesState createState() => ProductImagesState();
}

class ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: AspectRatio(
            aspectRatio: 1.02,
            child:
                // I used ClipRRect To Make The imageUrl Can Be Used Like String Not File
                ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(55)),
              // I Used The ConstServer.domainName Here To Make The imgUrl Give me The Image
              child:
                  widget.product.imgUrl == null ? Image.asset('assets/images/big_logo.png') : Image.network('${ConstServer.domaiNname}/' + widget.product.imgUrl),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: kSecondaryColor.withOpacity(0.1),
            //     image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: ConstServer.domaiNname + widget.product
            //           .imgUrl, //HomeScreen.control.images[widget.product.id!].image,
            //     ),
            //   ),
            // ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ...List.generate(widget.product.images.length,
        //         (index) => buildSmallProductPreview(index)),
        //   ],
        // )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        //duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        // child: Image.asset(widget.product.imgUrl),
      ),
    );
  }
}
