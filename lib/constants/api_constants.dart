const apiKey = "732174632c041bebcf360bf7f71fff22";
String url = "https://api.themoviedb.org/3/search/movie";

// https://api.themoviedb.org/3/search/movie?api_key=732174632c041bebcf360bf7f71fff22&language=en-US&query=avengers&page=1&include_adult=false

String baseUrl(String query) {
  Map<String, String> parameters = {
    "?api_key=": apiKey,
    "&language=": "en-US",
    "&query=": query,
    "&page=": "1",
    "&include_adult=": "false",
  };

  parameters.forEach((key, value) {
    url += key + value;
  });
  return url;
}
