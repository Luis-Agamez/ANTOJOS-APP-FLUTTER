import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import '../widgets/searchbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SearchBar(),
            //   Container(
            // width: double.infinity,
            // height: size.height * 0.6,
            // // color: Colors.red,
            // child: Swiper(
            //   itemCount: movies.length,
            //   layout: SwiperLayout.STACK,
            //   itemWidth: size.width * 0.65,
            //   itemHeight: size.height * 0.55,
            //   itemBuilder: (BuildContext context, int index) {
            //     final movie = movies[index];
            //     movie.heroId = 'swipwe-${movie.id}';
            //     return GestureDetector(
            //       onTap: () =>
            //           Navigator.pushNamed(context, 'details', arguments: movie),
            //       child: Hero(
            //         tag: movie.heroId!,
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(20),
            //           child: FadeInImage(
            //             placeholder: const AssetImage('assets/no-image.gif'),
            //             image: NetworkImage(movie.fullPosterImg),
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ))
          ],
        ),
      ),
    );
  }
}
