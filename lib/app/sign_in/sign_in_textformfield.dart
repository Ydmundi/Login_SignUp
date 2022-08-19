// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/change_provider.dart';

class SignInTextFormField extends StatelessWidget {
  const SignInTextFormField({
    Key? key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    //height: 160,
                    width: MediaQuery.of(context).size.width * 1,
                    //color: Colors.red,
                    
                      child: Form(
    key: _formKey,
    child: Column(
      children: <Widget>[
                      
        TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("^0[0-9]*")),
          ],
          maxLength: 11,
          decoration: const InputDecoration(
            counterText: '',
            prefixIcon: Icon(Icons.phone_android),
            prefixIconConstraints: BoxConstraints(),
            hintText: 'Phone Number(09)',
            errorStyle: TextStyle(
              
            ), 
          ),
          validator: (value){
            if(value!.isEmpty){
              return 'Phone Number can not be empty';
            }else if(value.length < 11 ){
              return 'Invalid Phone Number';
            }else if(value[1]!='9'){
              return 'Please start with "09"';
            }else{
              return null;
            }
            
          },
        ),
                      
        
        Padding(
          padding: const EdgeInsets.only(top:7,bottom: 7),
          child: TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              prefixIconConstraints: BoxConstraints(),
              hintText: 'Password',
            ),
            validator: (value){
            if(value!.isEmpty){
              return 'Password can not be empty';
            }else if(value.length < 8 ){
              return 'Password should be more than 8 characters';
            }else{
              return null;
            }
            
          },
          ),
        ),
                      
        
        Visibility(
          
          visible: (context.watch<Change>().count == 0) ? true : false,
          child: TextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z .]")),
            ],
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.edit),
              prefixIconConstraints: BoxConstraints(),
              hintText: 'Fullname',
              
            ),
            validator: (value){
              if(value!.isEmpty){
                return 'Give us your Full Name';
              }else{
                return null;
              }
            },
          ),
        ),
                      
                      
          ],
        ),
      ),
                    
    );
  }
}