import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/model/flash_sale_model.dart';
import 'package:project_detect_disease_datn/model/product_model.dart';
import 'package:project_detect_disease_datn/utils/format.dart';
import 'package:project_detect_disease_datn/viewmodels/flash_sale_view_model.dart';
import 'package:project_detect_disease_datn/viewmodels/product_view_model.dart';
import 'package:flutter/material.dart';

class TogetherProductShop extends StatelessWidget {
  const TogetherProductShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 7, bottom: 15, left: 8, right: 8),
            child: Row(
              children: [
                Text(
                  "SẢN PHẨM CÙNG LOẠI",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Spacer(),
                Text(
                  "Xem tất cả",
                  style: TextStyle(color: Colors.red),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.red,
                )
              ],
            ),
          ),
          FlashSaleList(),
        ],
      ),
    );
  }
}

class FlashSaleList extends StatelessWidget {
  final List<ProductModel> _productViewModel = ProductViewModel().getProduct();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Colors.transparent,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: _productViewModel.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _productViewModel.length) {
            return _buildMore();
          }
          //final flashSale = _productViewModel[index];
          return FlashSaleItem(_productViewModel[index]);
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 8),
      ),
    );
  }

  GestureDetector _buildMore() {
    final Color color = Colors.deepOrange;
    return GestureDetector(
      onTap: () {
        print("click");
      },
      child: SizedBox(
        width: 150,
        height: double.infinity,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 45.0,
                height: 45.0,
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  border: Border.all(
                    color: color,
                    width: 2.5,
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                ),
              ),
              Text(
                "Xem thêm",
                style: TextStyle(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlashSaleItem extends StatelessWidget {
  final ProductModel product;

  const FlashSaleItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border:
              Border.all(width: 0.5, color: kSecondaryColor.withOpacity(0.2))),
      child: GestureDetector(
        onTap: () {
          print("click");
        },
        child: Column(
          children: [
            _buildProductImage(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  _buildName(),
                  SizedBox(height: 12),
                  _buildPrice(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _buildName() => Text(
        '${product.name}',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
  _buildProductImage() => Container(
        height: 100,
        width: 110,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          child: Image.network(
            product.image!,
            fit: BoxFit.cover,
          ),
        ),
      );
  RichText _buildPrice() => RichText(
        text: TextSpan(
          text: '\đ ',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '${Format().currency(product.price, decimal: false)}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
}
