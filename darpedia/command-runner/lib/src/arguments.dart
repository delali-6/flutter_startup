import 'package:command_runner/command_runner.dart';
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
}