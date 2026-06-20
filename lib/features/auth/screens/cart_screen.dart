import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../presentation/cart/screens/checkout_screen.dart';
import '../../../data/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ambil data dari provider
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Keranjang")),
      body: Column(
        children: [
          // ini list item
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];

                return ListTile(
                  // gambar
                  leading: Image.network(item.image, width: 50),
                  // nama produk
                  title: Text(item.name),
                  // harga produk
                  subtitle: Text("Rp ${item.price}"),
                  // tombol hapus
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      cart.removeItem(item);
                    },
                  ),
                );
              },
            ),
          ),

          // checkout
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Total: Rp ${cart.totalPrice}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // cart kosong kasih warning
                    if (cart.items.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Keranjang masih kosong")),
                      );
                      return;
                    }
                    // pindah ke checkout kalo udah
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CheckoutScreen()),
                    );
                  },
                  child: Text("Checkout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
