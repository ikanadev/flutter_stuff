import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Link {
  final String text;
  final String path;
  const Link({required this.text, required this.path});
}

class Topic {
  final String title;
  final List<Link> links;
  const Topic({required this.title, required this.links});
}

const paths = [
  Topic(title: "Canvas", links: [
    Link(text: "Weekly Chart", path: "/canvas/chart"),
    Link(text: "Two", path: "one"),
  ]),
  Topic(title: "Storage", links: [
    Link(text: "One", path: "one"),
    Link(text: "Two", path: "one"),
  ]),
];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter samples"), centerTitle: true),
      body: ListView(
        children: [
          for (final path in paths)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(path.title, style: textTheme.labelLarge),
                ),
                for (final link in path.links)
                  ListTile(
                    leading: const Icon(Icons.chevron_right),
                    title: Text(link.text),
                    dense: true,
                    onTap: () => context.push(link.path),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
