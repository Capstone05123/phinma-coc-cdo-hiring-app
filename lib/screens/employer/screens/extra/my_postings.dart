import 'package:cdo_hiring_app/controllers/employer/postingsController.dart';
import 'package:cdo_hiring_app/controllers/employer/profileController.dart';
import 'package:cdo_hiring_app/ui/spinnerOverlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScreenMyPostings extends StatefulWidget {
  const ScreenMyPostings({Key? key}) : super(key: key);

  @override
  _ScreenMyPostingsState createState() => _ScreenMyPostingsState();
}

class _ScreenMyPostingsState extends State<ScreenMyPostings> {
  final _postingsController = Get.put(PostingsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postingsController.fetchPostings();
  }

  _handleDeletePost(value) {
    toggleOverlay(context: context);
    _postingsController.deletePosting(value);
  }

  List<Slidable> _mapPosting(data) {
    List<Slidable> items = [];
    for (var i = 0; i < data.length; i++) {
      var widget = Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      data[i]["title"],
                      style: GoogleFonts.roboto(
                        fontSize: 16.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "₱" +
                        data[i]["salary"]
                            .toString()
                            .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                    style: GoogleFonts.roboto(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            LineIcons.hashtag,
                            size: 14,
                            color: Colors.black87,
                          ),
                          Text(
                            data[i]["projectLength"],
                            style: GoogleFonts.roboto(
                              fontSize: 14.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                LineIcons.hashtag,
                                size: 14,
                                color: Colors.black87,
                              ),
                              Text(
                                data[i]["experienceLevel"] + "-level",
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      "Posted on ",
                      style: GoogleFonts.roboto(
                        fontSize: 12.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data[i]["datePosted"],
                      style: GoogleFonts.roboto(
                        fontSize: 12.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        actions: [],
        secondaryActions: [
          IconSlideAction(
            foregroundColor: Colors.black87,
            caption: 'Edit',
            color: Colors.grey[100],
            icon: LineIcons.editAlt,
            onTap: () {},
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: LineIcons.alternateTrash,
            onTap: () => _handleDeletePost(data[i]["id"]),
          ),
        ],
      );
      items.add(widget);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 0,
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          "My Postings",
          style: GoogleFonts.roboto(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(onPressed: () => Get.back(), icon: Icon(LineIcons.times)),
        ],
        //iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: Obx(() => _postingsController.isLoading.value
          ? SpinKitChasingDots(
              color: Colors.blue[300],
              size: 16.0,
            )
          : _postingsController.postings.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LineIcons.inbox,
                        color: Colors.black45,
                        size: 155.0,
                      ),
                      Text(
                        "Empty",
                        style: GoogleFonts.roboto(
                          color: Colors.black45,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: _mapPosting(_postingsController.postings.reversed.toList()),
                )),
    );
  }
}
