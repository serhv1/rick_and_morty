import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image_widget.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;

  const SearchResult({
    super.key,
    required this.personResult,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonDetailPage(
                      person: personResult,
                    )));
      },
      child: Card(
        color: Colors.grey[800],
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SizedBox(
              child: PersonCacheImage(
                  height: 300,
                  width: double.infinity,
                  imageUrl: personResult.image),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                personResult.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                personResult.location.name,
                style: const TextStyle(
                  color: AppColors.greyBackground,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
