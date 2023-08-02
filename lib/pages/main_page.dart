import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superheroes/blocs/main_bloc.dart';
import 'package:superheroes/pages/superhero_page.dart';
import 'package:superheroes/resources/superheroes_colors.dart';
import 'package:superheroes/resources/superheroes_images.dart';
import 'package:superheroes/widgets/action_button.dart';
import 'package:superheroes/widgets/info_with_button.dart';
import 'package:superheroes/widgets/superhero_card.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainBloc bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: SuperHeroesColors.background,
        body: SafeArea(
          child: Center(
            child: MainPageContent(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

class MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = Provider.of<MainBloc>(context);
    return Stack(
      children: [
        MainPageStateWidget(),
        Align(
            alignment: Alignment.bottomCenter,
            child: ActionButton(
              text: "Next state",
              onTap: () => bloc.nextState(),
            ))
      ],
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 110),
        child: CircularProgressIndicator(
          color: SuperHeroesColors.blue,
          strokeWidth: 4,
        ),
      ),
    );
  }
}

class MainPageStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = Provider.of<MainBloc>(context);
    return StreamBuilder<MainPageState>(
      stream: bloc.observeMainPageState(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return SizedBox();
        }
        final MainPageState state = snapshot.data!;
        switch (state) {
          case MainPageState.loading:
            return LoadingIndicator();
          case MainPageState.noFavorites:
            return NoFavoritesWidget();
          case MainPageState.minSymbols:
            return MynSymbolsWidget();
          case MainPageState.nothinhFound:
            return NothingFound();
          case MainPageState.loadingError:
            return LoadingErrorWidgets();
          case MainPageState.searchResult:
            return SearchResultWidgets();
          case MainPageState.favorites:
            return FavoritesWidgets();
          default:
            return Center(
              child: Text(
                snapshot.data!.toString(),
                style: TextStyle(color: Colors.white),
              ),
            );
        }
      },
    );
  }
}

class FavoritesWidgets extends StatelessWidget {
  const FavoritesWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 90),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Search Results",
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 24, color: Colors.white),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SuperHeroCard(
            name: "Batman",
            realName: "Bruce Wayne",
            imageUrl:
                "https://www.superherodb.com/pictures2/portraits/10/100/639.jpg",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SuperheroPage(name: "Batman"),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SuperHeroCard(
            name: "Venom",
            realName: "Eddie Brook",
            imageUrl:
                "https://www.superherodb.com/pictures2/portraits/10/100/22.jpg",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SuperheroPage(name: "Venom"),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class SearchResultWidgets extends StatelessWidget {
  const SearchResultWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 90),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Your favorites",
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 24, color: Colors.white),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SuperHeroCard(
            name: "Batman",
            realName: "Bruce Wayne",
            imageUrl:
                "https://www.superherodb.com/pictures2/portraits/10/100/639.jpg",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SuperheroPage(name: "Batman"),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SuperHeroCard(
            name: "Ironman",
            realName: "Tony Stark",
            imageUrl:
                "https://www.superherodb.com/pictures2/portraits/10/100/85.jpg",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SuperheroPage(name: "Ironman"),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class MynSymbolsWidget extends StatelessWidget {
  const MynSymbolsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
          top: 100,
        ),
        child: Text(
          "At least a 3 symbols",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}


class NoFavoritesWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InfoWithButton(
          title: "No favorites yet",
          subtitle: "Search and add",
          buttonText: "Search",
          assetImage: SuperHeroesImages.ironman,
          imageHeight: 119,
          imageWidth: 108,
          imageTopPadding: 9
      )
    );
  }
}

class NothingFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InfoWithButton(
            title: "Nothing Found",
            subtitle: "Search for something else",
            buttonText: "Search",
            assetImage: SuperHeroesImages.hulk,
            imageHeight: 112,
            imageWidth: 84,
            imageTopPadding: 16,
        )
    );
  }
}

class LoadingErrorWidgets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InfoWithButton(
            title: "Error Happened",
            subtitle: "Please, Try Again",
            buttonText: "Retry",
            assetImage: SuperHeroesImages.superman,
            imageHeight: 126,
            imageWidth: 106,
            imageTopPadding: 22,
        )
    );
  }
}
