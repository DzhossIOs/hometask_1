import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superheroes/resources/superheroes_colors.dart';

class SuperHeroCard extends StatelessWidget {

  final String name;
  final String realName;
  final String imageUrl;
  final VoidCallback onTap;

  const SuperHeroCard({super.key,
    required this.name,
    required this.realName,
    required this.imageUrl,
    required this.onTap,

  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        color: SuperHeroesColors.indigo,
        child: Row(
          children: [
            Image.network(imageUrl, height: 70, width: 70,fit: BoxFit.cover),
            SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text(name.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700

                ),
                  ),
                Text(realName.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),
                )
              ]
            ),
            )
          ],
        ),

      ),
    );
  }
}
