import 'package:first/common/const/colors.dart';
import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  final ImageProvider avatarImage; // network image, asset Image 가 해당
  final List<Image> images;
  final int rating;
  final String email;
  final String content;

  const RatingCard({
    Key? key,
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          rating: rating,
          email: email,
        ),
        const SizedBox(height: 8.0,),
        _Body(content: content,),
        _Images()
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final int rating;
  final String email;

  const _Header({Key? key,
    required this.avatarImage,
    required this.rating,
    required this.email
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: avatarImage,
          radius: 12.0,
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        ...List.generate(5, (index) => Icon(
            index < rating ? Icons.star : Icons.star_border_outlined,
          color: PRIMARY_COLOR,
        )),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            style: TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14.0
            ),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


