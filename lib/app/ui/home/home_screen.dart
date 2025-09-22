import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:thancoder_general_static_server/app/ui/home/github_page.dart';
import 'package:thancoder_general_static_server/app/ui/home/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List<Widget> pages = [HomePage(), GithubPage()];
  @override
  Widget build(BuildContext context) {
    return TScaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.api), label: 'Github'),
        ],
      ),
    );
  }
}
