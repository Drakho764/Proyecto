import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/consts.dart';
import 'package:proyecto/login_screen.dart';
import 'package:proyecto/routes.dart';
import 'package:proyecto/services/local_storage.dart';
const bgColorD = Color(0xff232227);
const bgColorW = Color.fromARGB(255, 245, 245, 245);
var shadowColor = Colors.black.withOpacity(0.4);

class Home extends StatefulWidget{
  const Home ({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool tema =false;

class _HomeState extends State<Home> {

  Future logOut(BuildContext context) async{
    LocalStorage.prefs.remove('user');
    LocalStorage.prefs.remove('psw');
    LocalStorage.prefs.remove('isChecked');
     Navigator.push(context, MaterialPageRoute(builder: ((context)=> const LoginScreen())));
  }

  void initState(){
    if(LocalStorage.prefs.getBool('tema') != null){
      LocalStorage.prefs.getBool('tema') as bool == true 
      ? tema = true
      : tema = false;
    }
    super.initState();
  } // Practica 3
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        //backgroundColor: bgColor,
        drawer: createDrawer(), 
        appBar: AppBar(
           iconTheme: IconThemeData(color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? 
                Colors.black:
                Colors.white,),
          actions: [
            //Practica 3
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: 
            List.generate(5, (index) { 
              var iconList = [Icons.email, Icons.favorite, Icons.home,Icons.notifications,Icons.person];
              return Transform.scale(
              scale: 1.2,
              child: CircleAvatar(
                backgroundColor: index ==2? btnColor : Colors.transparent,
                radius: index==2 ? 35 : 20,
                child: Icon(iconList[index], color: 
                AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? 
                Colors.black:
                Colors.white,)),);},)
          ),
        ),

        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textWidget(text: "FoodHot", size: 32),
              textWidget(text: "Entregas en corto", size: 18),
              const SizedBox(height: 12),
               TabBar(
                indicatorColor: Colors.transparent,
                labelColor: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.black :
                Colors.white,
                unselectedLabelColor: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.black :
                Colors.white,
                tabs: const[
                  Tab(text: "Pizza",),
                  Tab(text: "Hamburguesas",),
                  Tab(text: "Quesadillas",),
                  Tab(text: "Pollos Rostizados",),
              ],
              ),
               Expanded(child: TabBarView(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    mainAxisExtent: 220,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8), 
                    itemCount: 6,
                    physics:const BouncingScrollPhysics() ,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? bgColor :
                Colors.black54,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8,
                            spreadRadius: 1)
                          ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           // Image.asset('assets/h$index.png', width: 100,height: 100,)
                            Image.asset('assets/h0.png', width: 120,height: 120,),
                            textWidget(size: 16, text: "Pizza caliente",),
                            const SizedBox(height: 5,),
                            textWidget(size: 16, text: "Como el sol",),
                            const SizedBox(height: 5,),

                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(size: 16, text: "\$100"),
                                const Icon(Icons.shopping_cart_checkout_rounded)
                              ],
                            ),
                            
                          ],
                        ),
                      );
                    })),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    mainAxisExtent: 220,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8), 
                    itemCount: 6,
                    physics:const BouncingScrollPhysics() ,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? bgColor :
                Colors.black54,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8,
                            spreadRadius: 1)
                          ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           // Image.asset('assets/h$index.png', width: 100,height: 100,)
                            Image.asset('assets/h0.png', width: 120,height: 120,),
                            textWidget(size: 16, text: "La básicona"),
                            const SizedBox(height: 5,),
                            textWidget(size: 16, text: "Como tú"),
                            const SizedBox(height: 5,),

                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(size: 16, text: "\$100"),
                                const Icon(Icons.shopping_cart_checkout_rounded)
                              ],
                            ),
                            
                          ],
                        ),
                      );
                    })),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    mainAxisExtent: 220,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8), 
                    itemCount: 6,
                    physics:const BouncingScrollPhysics() ,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? bgColor :
                Colors.black54,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8,
                            spreadRadius: 1)
                          ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           // Image.asset('assets/h$index.png', width: 100,height: 100,)
                            Image.asset('assets/h0.png', width: 120,height: 120,),
                            textWidget(size: 16, text: "Quekas"),
                            const SizedBox(height: 5,),
                            textWidget(size: 16, text: "Con queso, obvio"),
                            const SizedBox(height: 5,),

                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(size: 16, text: "\$100"),
                                const Icon(Icons.shopping_cart_checkout_rounded)
                              ],
                            ),
                            
                          ],
                        ),
                      );
                    })),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    mainAxisExtent: 220,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8), 
                    itemCount: 6,
                    physics:const BouncingScrollPhysics() ,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? bgColor :
                Colors.black54,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8,
                            spreadRadius: 1)
                          ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           // Image.asset('assets/h$index.png', width: 100,height: 100,)
                            Image.asset('assets/h0.png', width: 120,height: 120,),
                            textWidget(size: 16, text: "Poshito"),
                            const SizedBox(height: 5,),
                            textWidget(size: 16, text: "chiken, gallina ken"),
                            const SizedBox(height: 5,),

                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(size: 16, text: "\$100"),
                                const Icon(Icons.shopping_cart_checkout_rounded)
                              ],
                            ),
                            
                          ],
                        ),
                      );
                    })),
              ]))
      
            ],
          ),
        ),
      ),
      
    );
  }

  Widget textWidget({text, required double size, color}){
    return Text("$text", style: TextStyle(
              fontSize: size,
              color: color,
              fontWeight: FontWeight.bold,
            ),);
  }

   Widget createDrawer(){
    return Drawer(
      child:ListView(
        children: [
         const UserAccountsDrawerHeader( 
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300')
              ),
            accountName: Text('Paquirrito'),
            accountEmail: Text('paqui@gmail.com')
          ),
          ListTile(
            title:const Text( "Tema"),
            trailing: Switch(
              value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light, 
              onChanged: (bool value) {
                setState(() {
                  LocalStorage.prefs.setBool('tema', value);
                  tema=value;
                if (tema){
                  AdaptiveTheme.of(context).setLight();
                }else{
                  AdaptiveTheme.of(context).setDark();
                }
                });
                
              }
              ) ,
          ),
          
          ListTile(
             //Image.asset('assets/naranja.png'),
            trailing: Icon(Icons.logout),
            title: Text('Cerrar'),
            subtitle: Text('Sesión') ,
            onTap: (){
             logOut(context);
    
            },
          ),
          
        ],
      ),
    );
  }
}