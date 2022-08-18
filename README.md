<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Display images on full page with all zoomin zoomout functions

## Features

TODO: gallery slides functionality zoomin,zoomout,pinch zoomin,pinch zoomout,double tap zoomin-zoomout

## Getting started

TODO: To start using this package, add gallery_zoom_slides dependency to your pubspec.yaml

```dependencies:
           gallery_zoom_slides: "<latest_release>"
```

## Usage

TODO:

```List<String> arrayImages =
     ["https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg",
       "https://www.gardeningknowhow.com/wp-content/uploads/2019/09/flower-color-400x391.jpg"
     ];


     InkWell(
                   onTap: (){
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => GalleryZoomSlides(
                                 arrayImages,0)));
                   },
                   child:Container(
                     padding:EdgeInsets.all(10.0),
                     color: Colors.grey,
                     child: Text("View Gallery",style: TextStyle(
                         color: Colors.white
                     ),),
                   )
               ),


```

## Additional information

TODO: you can also set which index of image want to display initallly.
