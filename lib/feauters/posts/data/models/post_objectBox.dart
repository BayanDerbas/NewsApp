import 'package:objectbox/objectbox.dart';

@Entity()
class PostObjectBox {
  @Id()
  int id;

  String title;
  String body;

  PostObjectBox({this.id = 0, required this.title, required this.body});
}

