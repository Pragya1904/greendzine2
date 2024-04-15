import 'package:flutter/material.dart';

class CustomListCard extends StatelessWidget {
  const CustomListCard({Key? key,required this.data}) : super(key: key);
  final data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
              //padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.0),
              decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 3,
                    )
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
              Container(
                margin: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height*0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(data.avatar),fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ])
            ),
            Positioned(
              top: 0,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red, // Change the color of the badge as needed
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Text(
                  data.id<10 ? "0${data.id.toString()}" : data.id.toString() , // The number to display in the badge
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Text(data.firstName),
      ],
    );
  }
}
