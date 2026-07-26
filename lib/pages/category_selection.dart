import 'package:flutter/material.dart';
import 'package:wallpaper/utils/constants.dart';
import 'package:wallpaper/utils/responsive.dart';
import 'package:wallpaper/widgets/changeThemeButtonWidget.dart';

class CategorySelection extends StatefulWidget {
  const CategorySelection({super.key});

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  List<int> selected = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: const ChangeThemeButtonWidget(),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome!",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  "Please select any three categories to get started",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Responsive.isMobile(context)
                  ? categoryGrid(context)
                  : Center(
                      child: SizedBox(
                        width: size.width * 0.90,
                        child: categoryGrid(context),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                  onPressed: selected.length < 3 ? null : _saveCategory,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Get Started"),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_right_alt)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveCategory() {
    debugPrint("Clicked");
  }

  Widget categoryGrid(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2,
        crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        mainAxisExtent: 80,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selected.contains(index)) {
                selected.removeWhere((element) => element == index);
              } else {
                selected.add(index);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: selected.contains(index)
                  ? Theme.of(context).cardColor
                  : Theme.of(context).cardColor.withValues(alpha: 0.3),
            ),
            child: Center(
              child: Text(
                category[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
