const version = '0.0.1';

void main(List<String> arguments) {
  // Process the command-line arguments
  //For starter, we will just handle a simple 'version' 
  //argument to display the CLI version. If the user 
  //provides no arguments (which is the case when the 
  //arguments list is empty), we will inform them that 
  //there isn't any argument. For any other argument, 
  //we will display an unknown argument message.
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage(); //case of no arguments or help argument, we will print usage information to guide the user on how to use the CLI.
  }
  else if (arguments.first == 'version') {
    print('Darpedia CLI version $version');
  }
  else {
    printUsage(); //case of unknown argument, we will also print usage information to guide the user on how to use the CLI.
  }
}

void printUsage() {
  print("The following arguments are supported:");
  print("  version - Displays the current version of the Darpedia CLI.");
  print("  search <ARTICLE-NAME> - Searches for a specific article in Darpedia.");
  print("  help - Displays this usage information.");
  print("  (No arguments) - Displays a message indicating that an argument is missing.");
}
