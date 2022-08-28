abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessFailState extends NewsStates {
  final String error;

  NewsGetBusinessFailState(this.error);
}

class NewsSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsFailState extends NewsStates {
  final String error;

  NewsGetSportsFailState(this.error);
}

class NewsScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceFailState extends NewsStates {
  final String error;

  NewsGetScienceFailState(this.error);
}

class NewsSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchFailState extends NewsStates {
  final String error;

  NewsGetSearchFailState(this.error);
}

class NewsThemeChanged extends NewsStates {}
