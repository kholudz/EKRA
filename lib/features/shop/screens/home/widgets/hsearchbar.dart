import 'package:ekra/features/shop/screens/home/widgets/Search_screen.dart';
import 'package:flutter/material.dart';

class HsearchBar extends StatelessWidget {
  const HsearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          // Navigate to another page here
          // Example: Get.to(FavouriteScreen());
          //go to Search page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  "Search for construction equipment",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF858585),
                  ),
                ),
              ),
              SizedBox(width: 60),
              Icon(
                Icons.search,
                color: Color(0xFF858585),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
