import 'package:ekra/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ekra/features/shop/screens/product_detail/widgets/price_container.dart';
import 'package:ekra/features/shop/screens/product_detail/widgets/product_description.dart';
import 'package:ekra/features/shop/screens/product_detail/widgets/product_details.dart';
import 'package:ekra/features/shop/screens/product_detail/widgets/product_image.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.item});

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE7E6E1), Color(0xFFFAFAFA)],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  bottom: 200), // Adjust padding to avoid overlap
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProductImage(item: item),
                  ProductDetails(item: item),
                  PriceContainer(item: item),
                  ProductDescription(item: item),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xffFEBD59),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {
                        // Implement like button functionality
                      },
                    ),
                  ),
                  SizedBox(
                    width: 229,
                    height: 52,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFEBD59)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF333333)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Implement functionality
                      },
                      child: const Text('Check for Available'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
