import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';
import 'package:loja_virtual_pro/models/user.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager,__){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      validator: (name){
                        if(name.isEmpty){
                          return 'Campo Obrigatório';
                        }
                        else if(name.trim().split(' ').length <=1){
                          return 'Digite seu nome completo';
                        }

                        return null;
                      },
                      onSaved: (name) => user.name=name,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email){
                        if(email.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if(!emailValid(email)) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                      onSaved: (email) => user.email=email,


                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (pass){
                        if(pass.isEmpty){
                          return 'A Senha é obrigatória';
                        }
                        else if(pass.length <6){
                          return 'Senha deve ter 6 ou mais dígitos';
                        }
                        return null;
                      },

                      onSaved: (pass) => user.password=pass,

                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Repita a senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (pass){
                        if(pass.isEmpty){
                          return 'A repetição da senha é obrigatória';
                        }
                        else if(pass.length <6){
                          return 'Senha deve ter 6 ou mais dígitos';
                        }
                        return null;

                      },
                      onSaved: (pass) => user.confirmPassword=pass,
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        onPressed: userManager.loading ? null :(){
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();

                            if(user.password != user.confirmPassword){
                              scaffoldKey.currentState.showSnackBar(

                                  SnackBar(
                                    content: const Text('Senhas não coincidem'),
                                    backgroundColor: Colors.red,

                                  ));
                              return;
                            }

                           userManager.SignUp(
                              user: user,
                              onSuccess: (){

                                Navigator.of(context).pop();
                              },
                              onFail: (e){
                                scaffoldKey.currentState.showSnackBar(

                                    SnackBar(
                                      content:Text('Falha ao cadastrar $e'),
                                      backgroundColor: Colors.red,

                                    ));
                              },
                            );
                          }


                        },

                        child: userManager.loading ?
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                                  
                            ) :

                        const Text('Criar Conta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],

                );
              },
            ),
          ),
        )
      ),
    );
  }
}
