/*
 "_id": "68fd9194a51bde4f61c10fd0",
            "ProductName": "samsung galaxy s25",
            "ProductCode": 1761479544904612,
            "Img": 
            "Qty": 45,
            "UnitPrice": 500,
            "TotalPrice": 1199
*/

class ProductModel {
  final String productName;
  final int productCode;
  final String productImg;
  final int productQty;
  final int productUnitPrice;
  final int productTotalPrice;

  ProductModel({
    required this.productName,
    required this.productCode,
    required this.productImg,
    required this.productQty,
    required this.productUnitPrice,
    required this.productTotalPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      productName: jsonData['ProductName'],
      productCode: jsonData['ProductCode'] as int,
      productImg: jsonData['Img'],
      productQty: jsonData['Qty'] as int,
      productUnitPrice: jsonData['UnitPrice'] as int,
      productTotalPrice: jsonData['TotalPrice'] as int,
    );
  }
}
