import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:command_runner/command_runner.dart';

const version = '0.0.1';

void main(List<String> arguments) async { // main is now async to allow for await by the runner
  var runner = CommandRunner(); // Create a CommandRunner instance
  await runner.run(arguments); // call its run method with the arguments, awaiting it since it may be async
}

