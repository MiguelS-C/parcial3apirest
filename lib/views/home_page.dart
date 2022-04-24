import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:parcial3apirest/models/post.dart';
import 'package:parcial3apirest/services/remote_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Welcome>? photos;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData();
  }
  getData() async{
    
    photos = await RemoteService().getPhotos();
    if(photos !=null){
      setState(() {
        isLoaded = true;
      });
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parcial 3 API REST')
        ),
        body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
            itemCount: photos?.length,
            itemBuilder: (context, index){
            return Container(
              child: Column(
                children: [
                  Text(photos![index].title, 
                  maxLines: 2, overflow: TextOverflow.ellipsis, 
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                    ),
                    
                    Image.network(photos![index].url)
                ],
              ),
            );
          }),
          replacement: const Center(child: CircularProgressIndicator(),),
        ),
    );
  }
}