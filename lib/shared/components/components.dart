import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview.dart';

Widget BuildArticle(
        {required double Height,
        required double Width,
        required Article,
        required context}) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: Article['url']),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: Width * 0.2,
                height: Height * 0.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: Article['urlToImage'] != null
                            ? NetworkImage(
                                '${Article['urlToImage']}',
                              )
                            : AssetImage(
                                'assets/images/imgnotfound.png',
                              ) as ImageProvider,
                        fit: BoxFit.cover))),
            SizedBox(
              width: Width * 0.07,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsetsDirectional.only(end: 8),
                height: Height * 0.11,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Text(Article['title'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      Text(
                        Article['publishedAt'],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Width * 0.03,
                            color: Colors.grey),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );

Widget BuildListOfArticles(
        {required double Height,
        required double Width,
        required List Articles,
        isSearch = false}) =>
    ConditionalBuilder(
        condition: Articles.isNotEmpty,
        builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => BuildArticle(
                Height: Height,
                Width: Width,
                Article: Articles[index],
                context: context),
            separatorBuilder: (context, index) => separator(),
            itemCount: 10),
        fallback: (context) => isSearch
            ? Container(
          child: Center(child: Text('Developed by Badieh Nader',style: Theme.of(context).textTheme.bodyText1,)),
        )
            : Center(child: CircularProgressIndicator()));

Widget separator() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );

getColor({required isLight, required int current_index}) {
  if (isLight) {
    switch (current_index) {
      case 0:
        return Colors.deepOrange;
        break;
      case 1:
        return Colors.blueAccent;
        break;
      case 2:
        return Colors.green;
        break;
      default:
        return Colors.deepOrange;
    }
  } else {
    return Colors.black;
  }
}
