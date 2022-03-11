import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myshop/screen/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';


class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl,);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
   return Row(
     children: <Widget>[
     CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
       Spacer(),
     Expanded(child: Text(this.title),),
       Spacer(),
        IconButton(icon: const Icon(Icons.edit),onPressed:(){
          Navigator.of(context).pushNamed(EditProductScreen.routeName,
              arguments: id
          );
        },color: Theme.of(context).primaryColor,),
        IconButton(icon: const Icon(Icons.delete),
          onPressed:() async {
                try {
                  await Provider.of<Product>(context, listen: false)
                  .deleteProduct(id);
                    } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
          },
          color: Theme.of(context).errorColor,
        ),
      ],
      );
  }
}
// Row(children: <Widget>[
// IconButton(icon: Icon(Icons.edit),onPressed:(){},color: Theme.of(context).primaryColor,),
// IconButton(icon: Icon(Icons.delete),onPressed:(){}, color: Theme.of(context).errorColor,),
// ],),