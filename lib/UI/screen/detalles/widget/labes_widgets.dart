import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LabesWidgets extends StatelessWidget {
  final String titulo;
  final String value;
  final Uri? uri;
  const LabesWidgets({
    Key? key,
    required this.titulo,
    required this.value,
    this.uri,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$titulo: ",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        if (uri == null)
          Text(
            value,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        if (uri != null)
          TextButton(
            onPressed: () {
              launchUrl(uri!);
            },
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.blueAccent),
            ),
          ),
      ],
    );
  }
}
