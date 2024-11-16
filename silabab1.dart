import 'dart:async';

// a. Model Data
class User {
  String name;
  int age;
  late List<Product> products;
  Role? role;

  User({required this.name, required this.age, this.role});

  void viewProducts() {
    if (products.isNotEmpty) {
      print("Daftar Produk:");
      for (var product in products) {
        print(
            "- ${product.productName} : \$${product.price} (In Stock: ${product.inStock})");
      }
    } else {
      print("Tidak ada produk yang tersedia.");
    }
  }
}

class Product {
  String productName;
  double price;
  bool inStock;

  Product(
      {required this.productName, required this.price, required this.inStock});
}

// b. Enum Role
enum Role { Admin, Customer }

// c. Object-Oriented Programming (OOP)

class AdminUser extends User {
  AdminUser({required String name, required int age})
      : super(name: name, age: age, role: Role.Admin) {
    products = [];
  }

  void addProduct(Product product) {
    if (!product.inStock) {
      throw Exception(
          "Produk ${product.productName} sudah tidak tersedia dalam stok.");
    }
    products.add(product);
    print("Produk ${product.productName} berhasil ditambahkan.");
  }

  void removeProduct(String productName) {
    products.removeWhere((product) => product.productName == productName);
    print("Produk $productName berhasil dihapus.");
  }
}

class CustomerUser extends User {
  CustomerUser({required String name, required int age})
      : super(name: name, age: age, role: Role.Customer) {
    products = [];
  }

  @override
  void viewProducts() {
    super.viewProducts();
  }
}

Future<void> fetchProductDetails(Product product) async {
  print("Mengambil detail untuk produk ${product.productName}...");
  await Future.delayed(Duration(seconds: 2));
  print("Detail produk ${product.productName} berhasil diambil.");
}

void main() {
  var admin = AdminUser(name: "Admin1", age: 30);
  var customer = CustomerUser(name: "Customer1", age: 25);

  Map<String, Product> productList = {
    "Laptop": Product(productName: "Laptop", price: 1200.0, inStock: true),
    "Mouse": Product(productName: "Mouse", price: 25.0, inStock: true),
    "Keyboard": Product(productName: "Keyboard", price: 45.0, inStock: false)
  };

  try {
    admin.addProduct(productList["Laptop"]!);
    admin.addProduct(productList["Mouse"]!);
    admin.addProduct(productList["Keyboard"]!);
  } on Exception catch (e) {
    print("Kesalahan: $e");
  }

  print("\nProduk di Admin:");
  admin.viewProducts();

  print("\nProduk di Customer:");
  customer.viewProducts();
  fetchProductDetails(productList["Laptop"]!);
}
