import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image_widget.dart';

const String lastKnownLocation = 'Last known location:';

class PersonCard extends StatelessWidget {
  final PersonEntity person;
  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    const sizedBox16 = SizedBox(
      width: 16,
    );
    const sizedBox4 = SizedBox(
      width: 4,
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailPage(
              person: person,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Row(
          children: [
            PersonCacheImage(
              height: 166,
              width: 166,
              imageUrl: person.image,
            ),
            sizedBox16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0),
                  ),
                  sizedBox4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: person.status == 'Alive'
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(
                            4,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          '${person.status} - ${person.species}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    lastKnownLocation,
                    style: TextStyle(color: AppColors.greyBackground),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    person.location.name,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Origin:',
                    style: TextStyle(color: AppColors.greyBackground),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    person.origin.name,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  sizedBox16,
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
