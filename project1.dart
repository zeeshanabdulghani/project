import 'dart:io';

class MenuItem {
  String name;
  double price;

  MenuItem(this.name, this.price);
}

class Menu {
  List<MenuItem> items = [];

  void addItem(String name, double price) {
    items.add(MenuItem(name, price));
  }

  void displayMenu() {
    print("Menu:");
    for (var i = 0; i < items.length; i++) {
      print("${i + 1}. ${items[i].name} - \$${items[i].price}");
    }
  }
}

class Order {
  List<MenuItem> items = [];

  void addItem(MenuItem item) {
    items.add(item);
  }

  double calculateTotal() {
    double total = 0;
    for (var item in items) {
      total += item.price;
    }
    return total;
  }

  void displayOrder() {
    print("Order:");
    for (var i = 0; i < items.length; i++) {
      print("${i + 1}. ${items[i].name} - \$${items[i].price}");
    }
    print("Total: \$${calculateTotal()}");
  }
}

class Restaurant {
  Menu menu = Menu();
  List<Order> orders = [];

  void displayOptions() {
    print("\nOptions:");
    print("1. Display Menu");
    print("2. Place Order");
    print("3. View Orders");
    print("4. Exit");
  }

  void start() {
    menu.addItem("Burger", 8.99);
    menu.addItem("Pizza", 10.99);
    menu.addItem("Salad", 5.99);

    int choice;
    do {
      displayOptions();
      stdout.write("Enter your choice: ");
      choice = int.parse(stdin.readLineSync()!);

      switch (choice) {
        case 1:
          menu.displayMenu();
          break;

        case 2:
          placeOrder();
          break;

        case 3:
          viewOrders();
          break;

        case 4:
          print("Exiting the Restaurant Management System. Goodbye!");
          break;

        default:
          print("Invalid choice. Please try again.");
      }
    } while (choice != 4);
  }

  void placeOrder() {
    Order order = Order();
    menu.displayMenu();

    int itemChoice;
    do {
      stdout.write("Enter the item number to add to the order (0 to finish): ");
      itemChoice = int.parse(stdin.readLineSync()!);

      if (itemChoice > 0 && itemChoice <= menu.items.length) {
        order.addItem(menu.items[itemChoice - 1]);
      } else if (itemChoice != 0) {
        print("Invalid item number. Please try again.");
      }
    } while (itemChoice != 0);

    if (order.items.isNotEmpty) {
      orders.add(order);
      print("Order placed successfully!");
    } else {
      print("No items added to the order.");
    }
  }

  void viewOrders() {
    if (orders.isEmpty) {
      print("No orders placed yet.");
    } else {
      print("Orders:");
      for (var i = 0; i < orders.length; i++) {
        print("\nOrder ${i + 1}:");
        orders[i].displayOrder();
      }
    }
  }
}

void main() {
  Restaurant restaurant = Restaurant();
  restaurant.start();
}
