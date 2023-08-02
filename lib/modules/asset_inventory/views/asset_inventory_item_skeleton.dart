import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class AssetInventoryItemSkeleton extends StatelessWidget {
  const AssetInventoryItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                title: SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 16,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: BorderRadius.circular(8)),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                            height: 10,
                            width: MediaQuery.of(context).size.width / 3,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                            height: 10,
                            width: MediaQuery.of(context).size.width / 3,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
