import 'package:flutter/material.dart';
import '../../../data/services/product_service.dart';
import '../../auth/widgets/product_card.dart';
import '../../auth/widgets/custom_appbar.dart';
import '../../../data/models/product_model.dart';
import '../../auth/screens/cart_screen.dart';
import '../../../data/services/auth_service.dart';
import '../../auth/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final ProductService service = ProductService();

  final Color primaryBlue = Color(0xFF1565C0);
  final Color lightBlue = Color(0xFFE3F2FD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,

      appBar: CustomAppBar(
        title: "Catalog",
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
            },
          ),

          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: StreamBuilder<List<Product>>(
        stream: service.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: primaryBlue));
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return Center(
              child: Text(
                "Barang kosong",
                style: TextStyle(color: Colors.grey[700]),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}
