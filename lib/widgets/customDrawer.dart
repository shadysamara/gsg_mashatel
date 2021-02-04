import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:gsg_mashatel/backend/repository.dart';
import 'package:gsg_mashatel/backend/server.dart';
import 'package:gsg_mashatel/models/user.dart';
import 'package:gsg_mashatel/pages/mershant_pages/new_product_page.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: Repository.repository.appUser.logoUrl != null
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(Repository.repository.appUser.logoUrl),
                  )
                : CircleAvatar(
                    child: Text(Repository.repository.appUser.userName[0]
                        .toUpperCase()),
                  ),
            accountEmail: Text(Repository.repository.appUser.email),
            accountName: Text(Repository.repository.appUser.userName),
          ),
          Repository.repository.appUser.type == userType.mershant
              ? ListTile(
                  title: Text('Add Product'),
                  onTap: () {
                    Get.to(NewProduct());
                  },
                )
              : ListTile(
                  title: Text('Send Message'),
                ),
          ListTile(
            title: Text('LOGOUT'),
            onTap: () {
              signOut();
            },
          )
        ],
      ),
    );
  }
}
