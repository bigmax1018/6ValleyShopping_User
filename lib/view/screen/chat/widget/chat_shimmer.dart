import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:shimmer/shimmer.dart';

class ChatShimmer extends StatelessWidget {
  const ChatShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      reverse: true,
      itemBuilder: (context, index) {

        bool isMe = index%2 == 0;
        return Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Colors.grey[300]!,
          enabled: true,
          child: Row(mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start, children: [
              isMe ? const SizedBox.shrink() : const InkWell(child: CircleAvatar(child: Icon(Icons.person))),
              Expanded(child: Container(
                  margin: isMe ?  const EdgeInsets.fromLTRB(150, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 5, 50, 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        bottomLeft: isMe ? const Radius.circular(10) : const Radius.circular(0),
                        bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(10),
                        topRight: const Radius.circular(10),
                      ),
                      color: isMe ? Colors.grey[300] : ColorResources.iconBg()
                  ),
                  child: Container(height: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}