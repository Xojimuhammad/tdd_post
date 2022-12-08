import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_post/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:tdd_post/presentation/blocs/post/post_bloc.dart';
import '../../core/utils/utils_service.dart';

enum Status {
  create,
  update,
}

class DetailPage extends StatefulWidget {
  static const id = "/detail_page";
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  late Status status;
  String? id;

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  void getInitialData() {
    status = (BlocProvider.of<NavigationBloc>(context).state as OpenSuccessState).message["status"] as Status;
  }

  void getEditablePost(GetOnePostSuccessState currentState) {
    id = currentState.post.id;
    titleController = TextEditingController(text: currentState.post.title);
    bodyController = TextEditingController(text: currentState.post.body);
  }

  void save(BuildContext context) {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    if(status == Status.create) {
      BlocProvider.of<PostBloc>(context).add(CreatePostEvent(title: title, body: body));
    } else {
      BlocProvider.of<PostBloc>(context).add(EditPostEvent(title: title, body: body, id: id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (BuildContext navigationContext, state) {
        if(state is BackSuccessState) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(navigationContext);
          });
        }
      },
      builder: (context, navigationState) {
        return WillPopScope(
          onWillPop: () async {
            if(navigationState is BackSuccessState) {
              return true;
            } else {
              BlocProvider.of<NavigationBloc>(context).add(BackEvent());
              return false;
            }
          },
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if(state is GetOnePostSuccessState) {
                if (status.name == Status.update.name) {
                  getEditablePost(state);
                }
              }
              if(state is Error) {
                Utils.fireSnackBar(state.message, context);
              }
              if(state is CreatePostSuccessState || state is EditPostSuccessState) {
                BlocProvider.of<PostBloc>(context).add(GetAllPostEvent());
                BlocProvider.of<NavigationBloc>(context).add(BackEvent());
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(status == Status.create ? "Post Create" : "Post Update"),
                  actions: [
                    IconButton(
                      onPressed: () => save(context),
                      icon: const Icon(Icons.save),
                      color: Colors.white,
                      iconSize: 30,
                    )
                  ],
                ),
                body: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: titleController,
                              decoration: const InputDecoration(hintText: "Title"),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: bodyController,
                              decoration: const InputDecoration(hintText: "Content"),
                              maxLines: null,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if(state is Loading) const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}