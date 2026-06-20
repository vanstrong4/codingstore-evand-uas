import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/cart_provider.dart';
import '../../../data/models/cart_item.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Color(0xFF1565C0);

    return Container(
      margin: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(18)),
            child: Image.network(
              product.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),

          // CONTENT
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rp. ${product.price}",
                        style: TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // 🔥 INI YANG DIPERBAIKI
                      GestureDetector(
                        onTap: () {
                          final cart = Provider.of<CartProvider>(
                            context,
                            listen: false,
                          );

                          cart.addItem(
                            CartItem(
                              name: product.name,
                              price: product.price,
                              image: product.image,
                              description: product.description,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Ditambahkan ke keranjang")),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
