import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/services/transaction_service.dart';
import '../../../features/auth/screens/otp_authenticator.dart';

class CheckoutScreen extends StatelessWidget {
  Future<String?> showPinDialog(BuildContext context) {
    final pinController = TextEditingController();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text("Konfirmasi PIN"),
          content: TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Masukkan PIN 6 digit"),
            maxLength: 6,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, pinController.text);
              },
              child: const Text("Konfirmasi"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1565C0),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? Center(child: Text("Tidak ada item"))
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];

                      return ListTile(
                        leading: Image.network(item.image, width: 50),
                        title: Text(item.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rp ${item.price}"),
                            Text(
                              item.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rp ${cart.totalPrice}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1565C0),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      if (cart.items.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Keranjang kosong")),
                        );
                        return;
                      }

                      // STEP 1
                      final verified = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AuthVerificationScreen(),
                        ),
                      );

                      if (verified != true) {
                        return;
                      }

                      // STEP 2
                      final enteredPin = await showPinDialog(context);

                      if (enteredPin == null) {
                        return;
                      }

                      try {
                        final service = TransactionService();

                        await service.createTransaction(
                          items: cart.items,
                          total: cart.totalPrice,
                          enteredPin: enteredPin,
                        );

                        cart.clearCart();

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Sukses"),
                            content: const Text("Pembayaran berhasil"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: Text(
                      "Checkout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
