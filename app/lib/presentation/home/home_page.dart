import 'package:app/presentation/course/course_page.dart';
import 'package:app/presentation/enroll/enroll_page.dart';
import 'package:app/presentation/students/students_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final options = ['Alunos', 'Cursos', 'Matrícula'];
    final icons = [Icons.person, Icons.school_outlined, Icons.menu_book];
    final pages = [
      const StudentsPage(),
      const CoursePage(),
      const EnrollPage()
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('VR App'),
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        elevation: 2.5,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 22,
          right: 22,
        ),
        child: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return _HomeCardWidget(
              icon: icons.elementAt(index),
              text: options.elementAt(index),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => pages.elementAt(index),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _HomeCardWidget extends StatelessWidget {
  const _HomeCardWidget({
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super();

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            height: 76,
            child: Row(
              children: <Widget>[
                Icon(icon),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
