import 'package:command_runner/command_runner.dart';
import 'dart:async';
import 'dart:collection';
import '../command_runner.dart';

enum OptionType {
  flag, //boolean value, true if present, false if not
  option, //other types of options, such as string or number, which require a value
}

abstract class Argument {
  String get name;
  String? get help;

  Object? get defaultValue; //gets the default value of the argument, if any or required
  String? get valueHelp; // gets the help text for the value of the argument, if applicable

  String get usage; //shows how to use the argument, including its name and any value it requires
}

class Option extends Argument {
  Option (
    this.name, {
      required this.type,
      this.help,
      this.abbr,
      this.defaultValue,
      this.valueHelp,
  });

  @override
  final String name;

  final OptionType type;

  @override
  final String? help;

  final String? abbr; //abbreviation for the option, such as -h for --help

  @override
  final Object? defaultValue;

  @override
  final String? valueHelp;

  @override
  String get usage {
    if (abbr != null) {
      return '-$abbr, --$name: $help';
    }

    return '--$name: $help';
  }
}

abstract class Command extends Argument {
  @override
  String get name;

  String get description; //a brief description of what the command does

  bool get requiresArguments => false;

  late CommandRunner runner; //the CommandRunner that this command is associated with, set when the command is added to the runner

  @override
  String? help;

  @override
  String? defaultValue;

  @override
  String? valueHelp;

  final List<Option> _options = [];

  UnmodifiableSetView<Option> get options => UnmodifiableSetView(_options.toSet());

// Method to add an option to the command. Flag is an option that is treated as a boolean, true if present and false if not. It does not require a value.
  void addFlag(String name, {String? help, String? abbr, String? valueHelp}) {
    _options.add(Option(name, help: help, abbr: abbr, defaultValue: false, valueHelp: valueHelp, type: OptionType.flag),);
  }

// Method to add an option to the command. Option is an option that requires a value, such as a string or number. It can have a default value if not provided.
  void addOption(String name, {String? help, String? abbr, String? defaultValue, String? valueHelp}) {
    _options.add(Option(name, help: help, abbr: abbr, defaultValue: defaultValue, valueHelp: valueHelp, type: OptionType.option),);
  }
  
  FutureOr<Object?> run(ArgResults args); //the method that will be called when the command is executed, with the parsed arguments passed in

  @override
  String get usage {
    return '$name: $description';
  }
}

class ArgResults {
  Command? command;
  String? commandArg;
  Map<Option, Object?> options = {};

  //Returns true if object exists in options, false otherwise
  bool flag(String name) {
    //Only checking flag as I am certain that flags are booleans
    for (var option in options.keys.where((option) => option.type == OptionType.flag,)) {
      if (option.name == name) {
        return options[option] as bool;
      }
    }
    return false;
  }

  bool hasOption(String name) {
    return options.keys.any((option) => option.name == name);
  }

  ({Option option, Object? input}) getOption(String name) {
    var mapEntry = options.entries.firstWhere((entry) => entry.key.name == name && entry.key.abbr == name,);

    return (option: mapEntry.key, input: mapEntry.value);
  }
}