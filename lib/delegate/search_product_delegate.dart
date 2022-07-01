import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../blocs/history/history_bloc.dart';
import '../blocs/search/search_bloc.dart';
import '../services/constants.dart';
import '../widgets/card_view.dart';

class SearchProductDelegate extends SearchDelegate {
  SearchProductDelegate()
      : super(searchFieldLabel: 'Buscar', keyboardType: TextInputType.text);

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final historyBloc = BlocProvider.of<HistoryBloc>(context);
    searchBloc.getSearch(query);
    return BlocBuilder<SearchBloc, SearchState>(builder: (_, state) {
      return state.existsProducts
          ? ListView.separated(
              itemCount: state.products.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'details',
                      arguments: state.products[index]);
                  historyBloc.sendProduct(state.products[index].id);
                },
                child: CardView(
                  id: state.products[index].id,
                  price: '${state.products[index].price}',
                  tag: state.products[index].slug,
                  title: state.products[index].title,
                  text: state.products[index].description,
                  image: '${state.products[index].images}',
                ),
              ),
              separatorBuilder: (context, index) =>
                  const Divider(height: defaultPadding, color: Colors.black87),
            )
          : Center(
              child: Lottie.asset(
                  'assets/animations/96528-search-not-found.json'));
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Icon(Icons.search_outlined, size: 120, color: Colors.grey),
    );
  }
}
