import 'package:flutter/material.dart';
import 'package:m16assignment/product_contoller.dart';
import 'package:m16assignment/widget/product_card.dart';

class CrudeHome extends StatefulWidget {
  const CrudeHome({super.key});

  @override
  State<CrudeHome> createState() => _CrudeHomeState();
}

class _CrudeHomeState extends State<CrudeHome> {
  ProductController productController = ProductController();

  Future<void> fetchData() async {
    await productController.fetchProduct();
    setState(() {});
  }

  productDialog({
    String? name,
    String? img,
    String? id,
    int? qty,
    int? unitPrice,
    required bool isUpdate,
  }) {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController imgController = TextEditingController(text: img);
    TextEditingController unitPriceController = TextEditingController(
      text: qty != null ? qty.toString() : '',
    );
    TextEditingController qtyController = TextEditingController(
      text: qty != null ? qty.toString() : '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal.shade50,
        title: Text(isUpdate ? 'Update Product' : 'Add Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
              ),
            ),
            TextField(
              controller: imgController,
              decoration: InputDecoration(
                labelText: 'Product Image',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
              ),
            ),
            TextField(
              controller: qtyController,
              decoration: InputDecoration(
                labelText: 'Product Qty',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
              ),
            ),
            TextField(
              controller: unitPriceController,
              decoration: InputDecoration(
                labelText: 'Product Price',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
              ),
            ),
            Divider(thickness: 3, color: Colors.teal[800]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    int qtyParse = int.parse(qtyController.text) ?? 0;
                    int priceParese = int.parse(unitPriceController.text) ?? 0;

                    isUpdate
                        ? await productController.updateProduct(
                            id.toString(),
                            nameController.text,
                            imgController.text,
                            qtyParse,
                            priceParese,
                          )
                        : await productController.createProduct(
                            nameController.text,
                            imgController.text,
                            qtyParse,
                            priceParese,
                          );

                    fetchData();
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Crud Product Management',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Product List',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: productController.products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (context, index) {
                  final product = productController.products[index];
                  return ProductCard(
                    product: product,
                    onDelete: () async {
                      final value = await productController.fetchDelete(
                        product.sId.toString(),
                      );
                      fetchData();
                    },
                    onUpdate: () {
                      productDialog(
                        isUpdate: true,
                        name: product.productName,
                        img: product.img,
                        qty: product.qty,
                        unitPrice: product.unitPrice,
                        id: product.sId,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(isUpdate: false),
        child: Text(
          '➕',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
