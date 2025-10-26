import 'package:fetch_product/api_config.dart';
import 'package:fetch_product/product_model.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel> productList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    if (productList.isEmpty) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      productList = await ApiConfig.fetchProducts();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load products: $e')));
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  
  Widget _buildPlaceholder() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.grey[500],
      child: const Icon(
        Icons.image_not_supported,
        size: 40,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: RefreshIndicator(
        onRefresh: _loadProducts,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : productList.isEmpty
            ? const Center(child: Text('No products found. Pull to refresh.'))
            : ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];

                  Widget imageWidget;
                  bool isValidUrl =
                      product.productImg.isNotEmpty &&
                      (product.productImg.startsWith('http://') ||
                          product.productImg.startsWith('https://'));

                  if (isValidUrl) {
                    imageWidget = Image.network(
                      product.productImg,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2.0),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder();
                      },
                    );
                  } else {
                    imageWidget = _buildPlaceholder();
                  }

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: imageWidget,
                      ),
                      title: Text(
                        product.productName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Code: ${product.productCode}'),
                          Text('Qty: ${product.productQty}'),
                          Text('Unit Price: \$${product.productUnitPrice}'),
                          Text('Total Price: \$${product.productTotalPrice}'),
                        ],
                      ),
                      isThreeLine: false,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
