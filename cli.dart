import 'dart:io';
import 'package:http/http.dart' as http;

const version = '0.0.1';

void main(List<String> arguments) {
  // Process the command-line arguments and execute the corresponding functionality based on the provided arguments.
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage(); //case of no arguments or help argument, we will print usage information to guide the user on how to use the CLI.
  }
  else if (arguments.first == 'version') {
    print('Darpedia CLI version $version');
  }
  else if (arguments.first == 'wikipedia') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null; // Get the arguments after 'wikipedia'
    searchWikipediaArticle(inputArgs); //Call the function to search for a Wikipedia article, passing the remaining arguments as the article name. If no additional arguments are provided, it will prompt the user to enter an article name.
  } 
  else {
    printUsage(); //case of unknown argument, we will also print usage information to guide the user on how to use the CLI.
  }
}

void searchWikipediaArticle(List<String>? arguments) async {
  final String? articleName;

  // If no article name is provided as an argument, prompt the user to enter one.
  if (arguments == null || arguments.isEmpty) {
    print("No article name provided. Please provide an article name");
    final inputFromStdin = stdin.readLineSync(); // Read the article name from user input
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print("No article name provided. Exiting.");
      return; // Exit if no article name is provided
    }
    articleName = inputFromStdin; // Use the user input as the article name
  } else {
    articleName = arguments.join(' '); // Join the arguments to form the article name
  }

  // Placeholder for search functionality
  print('Searching for article: $articleName');
  
  var articleSummary = await fetchWikipediaArticle(articleName); // Fetch the article summary from Wikipedia
  print('Article Summary: $articleSummary'); // Print the article summary to the console
}

void printUsage() {
  print("The following arguments are supported:");
  print("  version - Displays the current version of the Darpedia CLI.");
  print("  search <ARTICLE-NAME> - Searches for a specific article in Darpedia.");
  print("  help - Displays this usage information.");
  print("  (No arguments) - Displays a message indicating that an argument is missing.");
}

Future<String> fetchWikipediaArticle(String articleName) async {
  final url = Uri.https('en.wikipedia.org', '/api/rest_v1/page/summary/${Uri.encodeComponent(articleName)}'); //API endpoint to fetch the summary of a Wikipedia article based on the article name provided by the user. The article name is URL-encoded to ensure it can be safely included in the URL.
  final response = await http.get(url); //Make the HTTP GET request

  if (response.statusCode == 200) {
    return response.body; // Return the article summary as a string
  } else {
    throw Exception('Failed to load article: ${articleName} Status: ${response.statusCode}');
  }
}
