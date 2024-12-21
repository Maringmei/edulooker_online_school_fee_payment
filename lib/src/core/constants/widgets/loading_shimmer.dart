import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  final int? count;
  const LoadingWidget({super.key, this.count});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: count ?? 10, // Adjust the count based on your needs
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 30,
              width: 30,
              color: Colors.white,
            ),
            title: Container(
              height: 10,
              width: 200,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 10,
              width: 10,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
