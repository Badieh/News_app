import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController search = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        double height = size.height;
        double width = size.width;

        var cubit = NewsCubit.get(context);
        List Articles = cubit.Search;

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey),
                      controller: search,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Type something to search';
                        }
                      },
                      onChanged: (value) {
                        cubit.getSearch(value: value);
                      },
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {}
                      },
                      decoration: InputDecoration(
                        hintText: 'Type something to search',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Expanded(
                      child: BuildListOfArticles(
                          Height: height,
                          Width: width,
                          Articles: Articles,
                          isSearch: true))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
