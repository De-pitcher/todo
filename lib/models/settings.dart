// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

@immutable
class Settings {
  final bool deleteOnComplete;
  const Settings({this.deleteOnComplete = false});
}
