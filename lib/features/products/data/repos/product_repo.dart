import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/product_model.dart';

@lazySingleton
class ProductRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ── Fetch all products ────────────────────────────────────────────────────
  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map(ProductModel.fromJson).toList();
  }

  // ── Fetch by category ─────────────────────────────────────────────────────
  Future<List<ProductModel>> getByCategory(String category) async {
    final snapshot = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();
    return snapshot.docs.map(ProductModel.fromJson).toList();
  }

  // ── Seed mock data (run once) ─────────────────────────────────────────────
  Future<void> seedProducts() async {
    final col = _firestore.collection('products');
    final existing = await col.limit(1).get();
    if (existing.docs.isNotEmpty) return; // already seeded

    final products = [
      {
        'name': 'Wireless Headphones',
        'description': 'Premium sound with noise cancellation.',
        'price': 89.99,
        'imageUrl': 'https://picsum.photos/seed/headphones/400/400',
        'category': 'Electronics',
        'stock': 15,
      },
      {
        'name': 'Running Shoes',
        'description': 'Lightweight shoes for everyday running.',
        'price': 59.99,
        'imageUrl': 'https://picsum.photos/seed/shoes/400/400',
        'category': 'Fashion',
        'stock': 30,
      },
      {
        'name': 'Leather Backpack',
        'description': 'Durable leather bag with multiple compartments.',
        'price': 45.00,
        'imageUrl': 'https://picsum.photos/seed/backpack/400/400',
        'category': 'Fashion',
        'stock': 20,
      },
      {
        'name': 'Smart Watch',
        'description': 'Track fitness and notifications on your wrist.',
        'price': 129.99,
        'imageUrl': 'https://picsum.photos/seed/watch/400/400',
        'category': 'Electronics',
        'stock': 10,
      },
      {
        'name': 'Coffee Maker',
        'description': 'Brew the perfect cup every morning.',
        'price': 39.99,
        'imageUrl': 'https://picsum.photos/seed/coffee/400/400',
        'category': 'Home',
        'stock': 25,
      },
      {
        'name': 'Yoga Mat',
        'description': 'Non-slip mat for yoga and stretching.',
        'price': 24.99,
        'imageUrl': 'https://picsum.photos/seed/yoga/400/400',
        'category': 'Sports',
        'stock': 40,
      },
    ];

    final batch = _firestore.batch();
    for (final p in products) {
      batch.set(col.doc(), p);
    }
    await batch.commit();
  }
}