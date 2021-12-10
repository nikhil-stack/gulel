import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  //const CategoryItem({ Key? key }) : super(key: key);
  final String id;
  final String title;
  final String imageUrl;
  CategoryItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                                onTap:() => Navigator.of(context).pushNamed('/products-screen', arguments: {'id': title}),
      child: GridTile(
        child: Stack(
          children: [

            

               Container(
                /*decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2)),*/
                height: 500,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          /*gradient: LinearGradient(
                            colors: [Colors.white.withOpacity(0.5), Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),*/
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
            Positioned(
              left: 50,
              width: 90,
              bottom: 100,
              height: 100,
              child:
                  /*ClipRRect(
                child: Image.network(
                  'https://www.eatthis.com/wp-content/uploads/sites/4/2021/08/secret-effects-eating-almonds.jpg?quality=82&strip=1&resize=640%2C360',
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),*/
                  Transform.rotate(
                angle: 0,
                child: Container(
                    decoration: new BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(imageUrl)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
