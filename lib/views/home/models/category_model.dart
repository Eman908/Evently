import 'package:flutter/material.dart';

class CategoryModel {
  final String enName;
  final String arName;
  final int id;
  final String imagePath;
  final IconData iconData;

  CategoryModel({
    required this.enName,
    required this.arName,
    required this.id,
    required this.imagePath,
    required this.iconData,
  });
  static List<CategoryModel> categories = [
    CategoryModel(
      enName: "Sport",
      arName: "رياضة",
      id: 1,
      imagePath: "assets/categories/Sport.png",
      iconData: Icons.sports_soccer,
    ),
    CategoryModel(
      enName: "Birthday",
      arName: "عيد ميلاد",
      id: 2,
      imagePath: "assets/categories/birthday.png",
      iconData: Icons.cake,
    ),
    CategoryModel(
      enName: "Meeting",
      arName: "اجتماع",
      id: 3,
      imagePath: "assets/categories/meeting.png",
      iconData: Icons.people,
    ),
    CategoryModel(
      enName: "Gaming",
      arName: "ألعاب",
      id: 4,
      imagePath: "assets/categories/gaming.png",
      iconData: Icons.videogame_asset,
    ),
    CategoryModel(
      enName: "Exhibition",
      arName: "معرض",
      id: 5,
      imagePath: "assets/categories/exhibition.png",
      iconData: Icons.museum,
    ),
    CategoryModel(
      enName: "Eating",
      arName: "تناول الطعام",
      id: 6,
      imagePath: "assets/categories/eating.png",
      iconData: Icons.restaurant,
    ),
    CategoryModel(
      enName: "Workshop",
      arName: "ورشة عمل",
      id: 7,
      imagePath: "assets/categories/workshop.png",
      iconData: Icons.work,
    ),
    CategoryModel(
      enName: "Holiday",
      arName: "عطلة",
      id: 8,
      imagePath: "assets/categories/holiday.png",
      iconData: Icons.beach_access,
    ),
    CategoryModel(
      enName: "Book Club",
      arName: "نادي الكتاب",
      id: 9,
      imagePath: "assets/categories/book_club.png",
      iconData: Icons.menu_book,
    ),
  ];
}
