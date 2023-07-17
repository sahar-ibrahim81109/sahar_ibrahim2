import 'package:flutter_application_1/models/todos_model.dart';
import 'package:flutter_application_1/services/todos_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view2/todos_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosCubit(),
      child:BlocConsumer<TodosCubit, TodosState>(
      builder: (context, state) {
        if(state is TodosLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(state is TodosSuccess){
          return ListView.builder(
            itemCount:context.watch<TodosCubit>().data.length,
            itemBuilder: (BuildContext context,int index) {
              return ListTile(
                leading: Text(context.watch<TodosCubit>().data[index].id.toString()),
                title: Text(context.watch<TodosCubit>().data[index].title ??"--"),
                subtitle: Text(context.watch<TodosCubit>().data[index].completed.toString()),
                trailing: Icon(Icons.home),
              );
            },
          );
        }else{
            return const Center(
              child: Text('Error'),
            );
          }
      },
      listener:(context,state){
            if(state is TodosError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('we have error !!'),
                ));
            }
          },
        ),
      );
    }
  }
          
  
