part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}
final class CatgeoriesImageChanges extends CategoriesEvent{
final String image;
CatgeoriesImageChanges(this.image);
}
final class TextChanges extends CategoriesEvent{
  final String text;
  TextChanges(this.text);
}
final class CategoriesFormSubmit extends CategoriesEvent{
  
}