import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final int sold;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final Dimensions? dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta? meta;
  final List<String> images;
  final String thumbnail;
  final bool isFavourite;
  final List<String> colors;
  final List<String> sizes;

  const Product({
    required this.id,
    required this.title,
    this.description = '',
    this.category = '',
    this.price = 0.0,
    this.discountPercentage = 0.0,
    this.rating = 0.0,
    this.stock = 0,
    this.sold = 0,
    this.tags = const [],
    this.brand = '',
    this.sku = '',
    this.weight = 0,
    this.dimensions,
    this.warrantyInformation = '',
    this.shippingInformation = '',
    this.availabilityStatus = '',
    this.reviews = const [],
    this.returnPolicy = '',
    this.minimumOrderQuantity = 1,
    this.meta,
    this.images = const [],
    this.thumbnail = '',
    this.isFavourite = false,
    this.colors = const [],
    this.sizes = const [],
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    int? sold,
    List<String>? tags,
    String? brand,
    String? sku,
    int? weight,
    Dimensions? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<Review>? reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    Meta? meta,
    List<String>? images,
    String? thumbnail,
    bool? isFavourite,
    List<String>? colors,
    List<String>? sizes,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        price: price ?? this.price,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        rating: rating ?? this.rating,
        stock: stock ?? this.stock,
        sold: sold ?? this.sold,
        tags: tags ?? this.tags,
        brand: brand ?? this.brand,
        sku: sku ?? this.sku,
        weight: weight ?? this.weight,
        dimensions: dimensions ?? this.dimensions,
        warrantyInformation: warrantyInformation ?? this.warrantyInformation,
        shippingInformation: shippingInformation ?? this.shippingInformation,
        availabilityStatus: availabilityStatus ?? this.availabilityStatus,
        reviews: reviews ?? this.reviews,
        returnPolicy: returnPolicy ?? this.returnPolicy,
        minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
        meta: meta ?? this.meta,
        images: images ?? this.images,
        thumbnail: thumbnail ?? this.thumbnail,
        isFavourite: isFavourite ?? this.isFavourite,
        colors: colors ?? this.colors,
        sizes: sizes ?? this.sizes,
      );

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: (json['id'] as num?)?.toInt() ?? 0,
        title: json['title']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        category: json['category']?.toString() ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        discountPercentage:
            (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        stock: (json['stock'] as num?)?.toInt() ?? 0,
        sold: (json['sold'] as num?)?.toInt() ?? 0,
        tags: json['tags'] is List
            ? (json['tags'] as List).map((x) => x.toString()).toList()
            : const [],
        brand: json['brand']?.toString() ?? '',
        sku: json['sku']?.toString() ?? '',
        weight: (json['weight'] as num?)?.toInt() ?? 0,
        dimensions: json['dimensions'] is Map
            ? Dimensions.fromMap(
                Map<String, dynamic>.from(json['dimensions'] as Map),
              )
            : null,
        warrantyInformation: json['warrantyInformation']?.toString() ?? '',
        shippingInformation: json['shippingInformation']?.toString() ?? '',
        availabilityStatus: json['availabilityStatus']?.toString() ?? '',
        reviews: json['reviews'] is List
            ? (json['reviews'] as List)
                .whereType<Map>()
                .map((x) => Review.fromMap(Map<String, dynamic>.from(x)))
                .toList()
            : const [],
        returnPolicy: json['returnPolicy']?.toString() ?? '',
        minimumOrderQuantity:
            (json['minimumOrderQuantity'] as num?)?.toInt() ?? 1,
        meta: json['meta'] is Map
            ? Meta.fromMap(Map<String, dynamic>.from(json['meta'] as Map))
            : null,
        images: json['images'] is List
            ? (json['images'] as List).map((x) => x.toString()).toList()
            : const [],
        thumbnail: json['thumbnail']?.toString() ?? '',
        isFavourite: json['isFavourite'] as bool? ?? false,
        colors: json['colors'] is List
            ? (json['colors'] as List).map((x) => x.toString()).toList()
            : const [],
        sizes: json['sizes'] is List
            ? (json['sizes'] as List).map((x) => x.toString()).toList()
            : const [],
      );

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'sold': sold,
        'tags': tags,
        'brand': brand,
        'sku': sku,
        'weight': weight,
        'dimensions': dimensions?.toMap(),
        'warrantyInformation': warrantyInformation,
        'shippingInformation': shippingInformation,
        'availabilityStatus': availabilityStatus,
        'reviews': reviews.map((x) => x.toMap()).toList(),
        'returnPolicy': returnPolicy,
        'minimumOrderQuantity': minimumOrderQuantity,
        'meta': meta?.toMap(),
        'images': images,
        'thumbnail': thumbnail,
        'isFavourite': isFavourite,
        'colors': colors,
        'sizes': sizes,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Product(id: $id, title: $title, category: $category, price: $price, stock: $stock)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@immutable
class Dimensions {
  final double width;
  final double height;
  final double depth;

  const Dimensions({
    this.width = 0.0,
    this.height = 0.0,
    this.depth = 0.0,
  });

  Dimensions copyWith({
    double? width,
    double? height,
    double? depth,
  }) =>
      Dimensions(
        width: width ?? this.width,
        height: height ?? this.height,
        depth: depth ?? this.depth,
      );

  factory Dimensions.fromMap(Map<String, dynamic> json) => Dimensions(
        width: (json['width'] as num?)?.toDouble() ?? 0.0,
        height: (json['height'] as num?)?.toDouble() ?? 0.0,
        depth: (json['depth'] as num?)?.toDouble() ?? 0.0,
      );

  factory Dimensions.fromJson(String source) =>
      Dimensions.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() => {
        'width': width,
        'height': height,
        'depth': depth,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Dimensions(width: $width, height: $height, depth: $depth)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dimensions &&
          runtimeType == other.runtimeType &&
          other.width == width &&
          other.height == height &&
          other.depth == depth;

  @override
  int get hashCode => Object.hash(width, height, depth);
}

@immutable
class Meta {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String barcode;
  final String qrCode;

  const Meta({
    this.createdAt,
    this.updatedAt,
    this.barcode = '',
    this.qrCode = '',
  });

  Meta copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? barcode,
    String? qrCode,
  }) =>
      Meta(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        barcode: barcode ?? this.barcode,
        qrCode: qrCode ?? this.qrCode,
      );

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'].toString())
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'].toString())
            : null,
        barcode: json['barcode']?.toString() ?? '',
        qrCode: json['qrCode']?.toString() ?? '',
      );

  factory Meta.fromJson(String source) =>
      Meta.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'barcode': barcode,
        'qrCode': qrCode,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Meta(createdAt: $createdAt, updatedAt: $updatedAt, barcode: $barcode, qrCode: $qrCode)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Meta &&
          runtimeType == other.runtimeType &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.barcode == barcode &&
          other.qrCode == qrCode;

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, barcode, qrCode);
}

@immutable
class Review {
  final int rating;
  final String comment;
  final DateTime? date;
  final String reviewerName;
  final String reviewerEmail;

  const Review({
    this.rating = 0,
    this.comment = '',
    this.date,
    this.reviewerName = '',
    this.reviewerEmail = '',
  });

  Review copyWith({
    int? rating,
    String? comment,
    DateTime? date,
    String? reviewerName,
    String? reviewerEmail,
  }) =>
      Review(
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        date: date ?? this.date,
        reviewerName: reviewerName ?? this.reviewerName,
        reviewerEmail: reviewerEmail ?? this.reviewerEmail,
      );

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        rating: (json['rating'] as num?)?.toInt() ?? 0,
        comment: json['comment']?.toString() ?? '',
        date: json['date'] != null
            ? DateTime.tryParse(json['date'].toString())
            : null,
        reviewerName: json['reviewerName']?.toString() ?? '',
        reviewerEmail: json['reviewerEmail']?.toString() ?? '',
      );

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() => {
        'rating': rating,
        'comment': comment,
        'date': date?.toIso8601String(),
        'reviewerName': reviewerName,
        'reviewerEmail': reviewerEmail,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Review(rating: $rating, comment: $comment, date: $date, reviewerName: $reviewerName)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Review &&
          runtimeType == other.runtimeType &&
          other.rating == rating &&
          other.comment == comment &&
          other.date == date &&
          other.reviewerName == reviewerName &&
          other.reviewerEmail == reviewerEmail;

  @override
  int get hashCode =>
      Object.hash(rating, comment, date, reviewerName, reviewerEmail);
}
