import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wallpaper/pages/image_detail.dart';
import 'package:wallpaper/utils/constants.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.imageUrl,
    required this.photographer,
    required this.color,
    required this.imageDetail,
    required this.photographerUrl,
  });

  final String imageUrl, photographer, color, imageDetail, photographerUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetail(
                    photographer: photographer,
                    image: imageDetail,
                    photographerUrl: photographerUrl,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage.memoryNetwork(
                imageScale: 0.5,
                placeholder: kTransparentImage,
                image: imageUrl,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 5, left: 15, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "By",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        photographer,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor(color),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
