library gallery_zoom_slides;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryZoomSlides extends StatefulWidget {
  @override
  stateGalleryZoomSlides createState() => stateGalleryZoomSlides();

  List<String> arrayImages;
  int varSelectedIndex;
  GalleryZoomSlides(this.arrayImages,this.varSelectedIndex);
}

class stateGalleryZoomSlides extends State<GalleryZoomSlides>{

  final pageController = PageController();

  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;
  double varScreenHeight = 0;
  double varScreenWidth = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 3), () {

      pageController.jumpToPage(widget.varSelectedIndex);

    });

  }
  void onPageChanged(int index) {
    widget.varSelectedIndex = index;
  }
  @override
  void dispose() {
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {

    print("double tap clicked");

    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  Widget funcLoader(bool isLoaderDisplay){
    return Positioned(

      top:varScreenHeight/2 - 20,left: varScreenWidth/2 - 20,

      child:

      Visibility(

        visible: isLoaderDisplay,
        child: Container(
            height: 50,width: 50,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),

              color: Colors.white,

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.all(8.0),
            child:ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Center(
                  child: SizedBox(
                    height: 30,width: 30,
                    child:CircularProgressIndicator(

                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.grey.shade500),
                      strokeWidth: 3.0,
                    ),
                  )
              ),
            )

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    this.varScreenHeight = MediaQuery.of(context).size.height;
    this.varScreenWidth = MediaQuery.of(context).size.width;

    return

      WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },

        child: new Scaffold(
            backgroundColor: Colors.white,

            body:
            SafeArea(
              child:
              Container(

                  child:  Stack(
                    children: <Widget>[

                      Positioned(
                        top: 0,left: 0,bottom: 0,right: 0,

                        child: PageView(
                            physics:new NeverScrollableScrollPhysics(),
                            controller: pageController,
                            onPageChanged: onPageChanged,
                            children:<Widget>[

                              for(int i=0;i<widget.arrayImages.length;i++)

                                GestureDetector(
                                  onDoubleTapDown: _handleDoubleTapDown,
                                  onDoubleTap: _handleDoubleTap,

                                  child:

                                  InteractiveViewer(
                                    transformationController: _transformationController,
                                    minScale: 1.0,
                                    maxScale: 3.0,
                                    panEnabled: true,
                                    scaleEnabled: true,
                                    boundaryMargin: EdgeInsets.all(100.0),

                                    child:
                                    CachedNetworkImage(
                                      imageUrl: "${widget.arrayImages[i]}",
                                      placeholder: (context, url) => Center(child: Container(height: 45,width: 45,child: this.funcLoader(true),),),
                                      errorWidget: (context, url, error) => new Icon(Icons.error),
                                    ),
                                  ),

                                )

                            ]
                        ),

                      ),

                      //left button
                      Positioned(
                          top: (varScreenHeight/2)-(60/2),left: 0,
                          child:  widget.arrayImages.length == 1 ? SizedBox(height: 0,) :InkWell(
                            onTap: (){

                              if(widget.varSelectedIndex != 0) {
                                widget.varSelectedIndex -= 1;
                              }
                              else{
                                widget.varSelectedIndex = widget.arrayImages.length-1;
                              }
                              pageController.jumpToPage(widget.varSelectedIndex);
                              setState(() {
                                widget.varSelectedIndex = widget.varSelectedIndex;
                              });

                            },
                            child: Container(
                              height: 60,width: 30,
                              color: Colors.black.withOpacity(0.3),

                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,color: Colors.white,
                                ),
                              ),
                            ),
                          )
                      ),

                      //right button
                      Positioned(
                          top: (varScreenHeight/2)-(60/2),right: 0,
                          child: widget.arrayImages.length == 1 ? SizedBox(height: 0,) : InkWell(
                            onTap: (){
                              if(widget.varSelectedIndex != widget.arrayImages.length-1) {
                                widget.varSelectedIndex += 1;
                              }
                              else{
                                widget.varSelectedIndex = 0;
                              }
                              pageController.jumpToPage(widget.varSelectedIndex);
                              setState(() {
                                widget.varSelectedIndex = widget.varSelectedIndex;
                              });
                            },
                            child: Container(
                              height: 60,width: 30,
                              color: Colors.black.withOpacity(0.3),

                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,color: Colors.white,
                                ),
                              ),
                            ),
                          )
                      ),

                      //back button
                      Positioned(
                        top: 15,right: 10,
                        child:
                        InkWell(
                          onTap: (){
                            // back to previous screen
                            Navigator.pop(context);
                          },
                          child:

                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.white,width: 1.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                height: 28,width: 28,
                                child: Center(
                                  child: Icon(Icons.close,color: Colors.black,size: 22,),
                                ),
                              ),
                            ),
                          ),

                        ),
                      ),

                      Positioned(
                          bottom: 0,left: 0,right: 0,
                          child:  Container(
                            height: 60,
                            child: ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.arrayImages.length,
                                itemBuilder: (BuildContext context, int index) =>

                                    InkWell(
                                      onTap: (){
                                        pageController.jumpToPage(index);
                                        setState((){
                                          widget.varSelectedIndex = index;
                                        });
                                      },
                                      child:  Container(

                                          child: Row(
                                            children: [

                                              SizedBox(width: index == 0 ? 15 : 0,),
                                              SizedBox(width: 7,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    height: index == widget.varSelectedIndex ? 50 :40,width:index == widget.varSelectedIndex ? 50 : 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      border: Border.all(color: Colors.white,width: 1.0),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          spreadRadius: 1,
                                                          blurRadius: 1,
                                                          offset: Offset(0, 1), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      child: CachedNetworkImage(
                                                        imageUrl: "${widget.arrayImages[index]}",
                                                        placeholder: (context, url) => Container(height: 45,width: 45,child: this.funcLoader(true),),
                                                        errorWidget: (context, url, error) => new Icon(Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8,),
                                                  // Container(
                                                  //   height: 2,
                                                  //   width:50,
                                                  //   decoration: BoxDecoration(
                                                  //     borderRadius: BorderRadius.circular(10.0),
                                                  //     color: index == widget.varSelectedIndex ? ConstantColor.keyPrimaryOrange : Colors.transparent,
                                                  //   ),
                                                  //
                                                  // )
                                                ],
                                              ),
                                              SizedBox(width: 7,),
                                              SizedBox(width: index == widget.arrayImages.length-1 ? 15 : 0,),

                                            ],
                                          )
                                      ),
                                    )

                            ),
                          )

                      ),

                    ],
                  )

              ),
            )
        ),
      );
  }

}