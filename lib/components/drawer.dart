import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_moteis/components/my_list_tile.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              DrawerHeader(
                child: Center(
                  child: ClipOval(
                    child: Container(
                      height: 80,
                      width: 80,
                      color: Colors.grey[
                          400], // Cor de fundo caso a imagem demore para carregar
                      child: Icon(
                        Icons.person,
                        size: 72,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              // home list title
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
              ),
              // profile list tile
              MyListTile(
                icon: Icons.person,
                text: 'P E R F I L',
              ),
            ],
          ),
          // logout list tile
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.exit_to_app,
              text: 'L O G O U T',
            ),
          )
        ],
      ),
    );
  }
}
