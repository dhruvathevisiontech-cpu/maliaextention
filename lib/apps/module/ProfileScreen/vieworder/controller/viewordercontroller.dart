import 'package:get/get.dart';
class OrderStatusStep {
  final String title;
  final String date;
  final bool isCompleted;

  OrderStatusStep({
    required this.title,
    required this.date,
    required this.isCompleted,
  });
}

class OrderItem {
  final String title;
  final int quantity;
  final double price;

  OrderItem({
    required this.title,
    required this.quantity,
    required this.price,
  });
}
class Viewordercontroller extends GetxController {
  final placedDate = '26 Aug 2026'.obs;
  final trackingNumber = 'NK-45454-US'.obs;

  // Track active step index (0: Pending, 1: Confirmed, 2: Shipped, etc.)
  final currentStepIndex = 0.obs;

  final statusSteps = <OrderStatusStep>[
    OrderStatusStep(title: 'Pending', date: '26 Aug', isCompleted: true),
    OrderStatusStep(title: 'Confirmed', date: '28 Aug', isCompleted: false),
    OrderStatusStep(title: 'Shipped', date: '29 Aug', isCompleted: false),
    OrderStatusStep(title: 'Out for\ndelivery', date: '29 Aug', isCompleted: false),
    OrderStatusStep(title: 'Delivered', date: '30 Aug', isCompleted: false),
  ].obs;

  final orderItems = <OrderItem>[
    OrderItem(title: 'The Classic Butterfly Weft', quantity: 1, price: 245.0),
    OrderItem(title: 'Genius Weft', quantity: 1, price: 245.0),
  ].obs;

  double get totalPrice =>
      orderItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
}