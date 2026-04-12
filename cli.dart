import 'dart:io';

const version = '0.0.1';

void main(List<String> arguments) {
  // Process the command-line arguments and execute the corresponding functionality based on the provided arguments.
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage(); //case of no arguments or help argument, we will print usage information to guide the user on how to use the CLI.
  }
  else if (arguments.first == 'version') {
    print('Darpedia CLI version $version');
  }
  else if (arguments.first == 'search') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null; // Get the arguments after 'search'
    searchArticle(inputArgs);
  } 
  else {
    printUsage(); //case of unknown argument, we will also print usage information to guide the user on how to use the CLI.
  }
}

void searchArticle(List<String>? arguments) {
  final String articleName;
  if (arguments == null || arguments.isEmpty) {
    print("No article name provided. Please provide an article name");
    articleName = stdin.readLineSync() ?? ""; // Read the article name from user input
  } else {
    articleName = arguments.join(' '); // Join the arguments to form the article name
  }
  // Placeholder for search functionality
  print('Searching for article: $articleName');
  print("Here it is!");
  print("(Pretend we found the article and display its content here.)");
}

void printUsage() {
  print("The following arguments are supported:");
  print("  version - Displays the current version of the Darpedia CLI.");
  print("  search <ARTICLE-NAME> - Searches for a specific article in Darpedia.");
  print("  help - Displays this usage information.");
  print("  (No arguments) - Displays a message indicating that an argument is missing.");
}
