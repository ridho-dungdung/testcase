
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/models/movie.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
   final List<Data> data;

  const HomeBlocLoadedScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return movieItemWidget(data[index], context);
      },
    ),
    );
  }

  Widget movieItemWidget(Data data, BuildContext context){
    return InkWell(
      onTap: () => showDetail(data, context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.network(
                data.i.imageUrl,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded
                          / loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(data.l, textDirection: TextDirection.ltr),
            )
          ],
        ),
      ),
    );
  }

  Future showDetail(Data data, BuildContext context) {
    return showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))
      ),
      builder: (context) => Container(
        height: (data.series != null )
            ? 670
            : 550,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(data.l, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Image.network(
                data.i.imageUrl,
                height: 320,
                fit: BoxFit.cover,
              )
            ),
            if(data.series != null) Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: data.series.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Image.network(
                    e.i.imageUrl,
                    fit: BoxFit.cover,
                    width: 300,
                    height: 200,
                    loadingBuilder: (context, child, loadingProgress) {
                      if(loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded
                              / loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                )).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              child: Column(
                children: [
                  Row(children: [
                    Text("Genre Movie: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16),),
                    Text(data.q,
                      style: TextStyle(fontSize: 16),)
                  ],),
                  Row(children: [
                    Text("Tahun Movie : ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),
                    Text(data.yr ?? data.year.toString(),
                      style: TextStyle(fontSize: 16),)
                  ],),
                  Row(children: [
                    Text("List Serial Movie : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),),
                    Text(data.s,
                      style: TextStyle(fontSize: 16),)
                  ],),

                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
