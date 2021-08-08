import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class PhotosSlider extends StatelessWidget {
  final List<String> imagesUrls;
  const PhotosSlider({Key key, this.imagesUrls}) : super(key: key);

  Future <List<Image>> getAllPhotosfromFireStoreUsingUrls()async{
    List<Image>propImages;
    for(int i=0;i<imagesUrls.length;i++){
     await propImages.add(Image.network(imagesUrls[i]));
    }
    return propImages ;
  }
  @override
  Widget build(BuildContext context) {
    //TODO make this as a future Builder ...to get all the photos from the Urls
    List<Image>propImages;
    for(int i=0;i<imagesUrls.length;i++){
       propImages.add(Image.network(imagesUrls[i]));
    }
    return Scaffold(
      body: Carousel(
        images: propImages,
      ),
    );
  }
}