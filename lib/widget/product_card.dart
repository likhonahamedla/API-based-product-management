import 'package:flutter/material.dart';
import 'package:m16assignment/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Data product;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onUpdate,
  });
  TextStyle textStyle({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.teal.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Image.network(product.img.toString(), fit: BoxFit.cover),
          ),

          Text(
            product.productName.toString(),
            style: textStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            'Qty:${product.qty.toString()}',
            style: textStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Text(
            'UnitPrice:${product.unitPrice.toString()}',
            style: textStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            'TotalPrice:${product.totalPrice.toString()}',
            style: textStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Divider(thickness: 2, color: Colors.teal[800]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onUpdate,
                icon: Icon(Icons.edit, size: 30, color: Colors.teal),
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete_rounded, size: 30, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
