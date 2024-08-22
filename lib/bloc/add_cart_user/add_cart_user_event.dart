part of 'add_cart_user_bloc.dart';


sealed class AddCartUserEvent{}
                                     
                                       
final class SubCatgeoryImage  extends AddCartUserEvent{
  final String catImage;
  SubCatgeoryImage(this.catImage);
}
final class SubCategoryHeading  extends AddCartUserEvent{
  final String catHeading;
  SubCategoryHeading(this.catHeading);
}
final class CategoryName  extends AddCartUserEvent{
  final String catName;
  CategoryName(this.catName);
}
final class CategoryDes  extends AddCartUserEvent{
  final String catDes;
  CategoryDes(this.catDes);
}
final class ItemPrice  extends AddCartUserEvent{
  final int itemPrice;
  ItemPrice(this.itemPrice);
}
final class SubCategoryIdChanges  extends AddCartUserEvent{
  final String catId;
  SubCategoryIdChanges(this.catId);
}
final class CartCheckBoxChnages extends AddCartUserEvent{
  final String id; 
  final bool isChecked;
    CartCheckBoxChnages(this.id, this.isChecked);
}
final class CartCheckBoxUnSave extends AddCartUserEvent{
  final String id; 
  final String userId;
    CartCheckBoxUnSave(this.id, this.userId);
}


final class FormSubmit extends AddCartUserEvent{}