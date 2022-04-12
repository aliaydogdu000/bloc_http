import 'package:bloc_weeknd/feature/bloc/cats_cubit.dart';
import 'package:bloc_weeknd/feature/bloc/cats_state.dart';
import 'package:bloc_weeknd/feature/service/cats_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCatsView extends StatelessWidget {
  const BlocCatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatsCubit(CatsService()),
      child: scaffoldBuilder(context),
    );
  }

  Scaffold scaffoldBuilder(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Cats Memes")),
        body: BlocConsumer<CatsCubit, CatsState>(builder: (context, state) {
          if (state is CatsInitial) {
            return buildInitialChild(context);
          } else if (state is CatsLoading) {
            return buildLoading();
          } else if (state is CatsCompleted) {
            return buildCompleted(state);
          } else {
            final error = state as CatsError;
            return buildError(error);
          }
        }, listener: (context, state) {
          if (state is CatsError) {
            Scaffold.of(context)
                .showBottomSheet((context) => Text(state.message));
          }
        }),
      );

  Text buildError(CatsError error) => Text(error.message);

  ListView buildCompleted(CatsCompleted state) {
    return ListView.builder(
      itemCount: state.response.length,
      itemBuilder: ((context, index) => ListTile(
            title: Image.network(state.response[index].imageUrl ?? ""),
            subtitle: Text(state.response[index].description ?? ""),
          )),
    );
  }

  Center buildLoading() => Center(child: CircularProgressIndicator());

  Center buildInitialChild(BuildContext context) {
    return Center(
      child: Column(
        children: [Text("Cats Memes"), buildFloattingActionButton(context)],
      ),
    );
  }

  FloatingActionButton buildFloattingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.clear_all),
      onPressed: () {
        context.read<CatsCubit>().getCats();
      },
    );
  }
}
