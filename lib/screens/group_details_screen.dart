import 'package:flutter/material.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({super.key});
  
  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen>{
  
  bool _isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();
  
  @override
  void dispose(){
    _searchFocusNode.dispose();
    super.dispose();
  }
  
  void _showLeaveDialog (){
    showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Вийти з групи?"),
            content: const Text("Ви більше не зможете читати нові повідомлення!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: const Text("Скасувати"),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ви вийшли з групи"),
                      ),
                    );
                  }, 
                  child: const Text("Вийти", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
    );
  }

  void _showMembersDialog(String memberName){
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text("Відкрити профіль $memberName"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star_border),
                    title: Text("Призначити адміністратором"),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, 
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: _isSearching
              ? TextField(
                focusNode: _searchFocusNode,
                style: const TextStyle(color: Colors.white,fontSize: 22),
                decoration: const InputDecoration(
                  hintText: "Пошук",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ): const Text("Деталі групи"),
            actions: [
              IconButton(
                  icon: Icon(_isSearching ? Icons.close : Icons.search),
                  onPressed: (){
                    setState(() {
                      _isSearching = !_isSearching;
                      if (_isSearching) _searchFocusNode.requestFocus();
                    });
                  },
              ),
              const EndDrawerButton(),
            ],
          ),
          endDrawer: Drawer(
            child: SafeArea(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text("Редагувати групу"),
                    ),
                    ListTile(
                      leading: Icon(Icons.link),
                      title: Text("Запрошувальне посилання"),
                    ),
                    ListTile(
                      leading: Icon(Icons.qr_code),
                      title: Text("QR-код групи"),
                    ),
                    ListTile(
                      leading: Icon(Icons.remove_circle),
                      title: Text("Покинути групу", style: TextStyle(color: Colors.red)),
                      onTap: (){
                        _showLeaveDialog();
                      },
                    ),
                  ],
                ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Додавання учасника")
                ),
              );
            },
            child: Icon(Icons.person_add, color: Colors.white),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            }, 
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        child: Container(
                          color: Colors.lightBlue,
                          width: double.infinity,
                          child: const Icon(Icons.group, size: 100, color: Colors.white),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Stack(
                      //     children: [
                      //       const CircleAvatar(
                      //         radius: 50,
                      //         backgroundColor: Colors.red,
                      //         child: Text("Test", style: TextStyle(color: Colors.white, fontSize: 30)),
                      //       ),
                      //       Positioned(
                      //         right: 0,
                      //         bottom: 5,
                      //         child: Badge(
                      //           backgroundColor: Colors.green,
                      //           smallSize: 20,
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: Colors.white,
                      //               border: Border.all(color: Colors.white, width: 2),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}