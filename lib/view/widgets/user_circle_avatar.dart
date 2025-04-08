import 'package:flutter/material.dart';

class UserCircleAvatar extends StatelessWidget {
  const UserCircleAvatar({
    super.key,
    required this.name,
    this.avatarUrl,
    this.radius,
  });

  final String name;
  final String? avatarUrl;
  final double? radius;

  String get _getLettersFromName {
    final firstLetter = name[0];

    final names = name.split(" ");
    names.remove("");
    names.remove(" ");
    if (names.length > 1) {
      return (firstLetter + names[1][0]).toUpperCase();
    } else {
      return (firstLetter + name[1]).toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
      child:
          avatarUrl == null
              ? Text(
                _getLettersFromName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: (radius ?? 28) / 2,
                ),
              )
              : null,
    );
  }
}
