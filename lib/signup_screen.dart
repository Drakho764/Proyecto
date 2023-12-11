import 'package:flutter/material.dart';
import 'package:proyecto/consts.dart';

class SignupScreen extends StatelessWidget{
  const SignupScreen ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent, ), // AppBar
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column ( crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const Text("Sign Up", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white
            ),),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/signup.png', width: 230,)),
              const SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.2)
                ),
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: btnColor,),
                    hintText: "Enter email or username",
                    border: InputBorder.none,

                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.2)
                ),
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: btnColor,),
                    hintText: "Enter your Password",
                    border: InputBorder.none,

                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.2)
                ),
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: btnColor,),
                    hintText: "Confirm your Password",
                    border: InputBorder.none,

                  ),
                ),
              ),
              SizedBox(height: 12,),
              Container(
                width: 400,
                height: 50,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: btnColor
                ),
                child: Text("Sign Up",
                style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white,))
              ),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text("Caray, ya tienes una cuenta?",
                style: TextStyle(
                  color: Colors.black54
                ),),
                SizedBox(width: 12,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text("Login",
                  style: TextStyle(
                    color: btnColor, fontWeight: FontWeight.bold
                  ),),
                )
                ],
              ),
          ],
        ), // Column
      ), // Container
    );
  }
}