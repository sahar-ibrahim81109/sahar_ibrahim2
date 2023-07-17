import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/models/todos_model.dart';
import 'package:flutter_application_1/services/todos_service.dart';
import 'package:meta/meta.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
    TodosCubit():super(TodosInitial()){
      getTodos();
    }
  
   List<Todos> data=[];
   bool isLoading=true;
  
  getTodos() async{
    emit(TodosLoading());
    try{
    data=await Todos_Service().getTodos();
    isLoading=false;
    emit(TodosSuccess());
  }
  catch (e){
    print(e.toString());
    emit(TodosError());
  }
}
}
