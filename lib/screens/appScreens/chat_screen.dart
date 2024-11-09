import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_iq/index.dart';
import 'package:chat_iq/models/message_model.dart';
import 'package:chat_iq/shared/cubits/app_cubit/cubit/app_cubit_cubit.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({
    super.key,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubitCubit.get(context).getAllMessage();
        return BlocConsumer<AppCubitCubit, AppCubitState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = AppCubitCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                        // backgroundImage: NetworkImage(
                        //   widget.reciverUser.imageLink,
                        // ),
                        ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'ChatIQ bot',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        MessageModel currMessage = cubit.allMessages[index];
                        return BubbleSpecialThree(
                          text: currMessage.content,
                          color: !currMessage.is_sender
                              ? const Color(0xFF1B97F3)
                              : const Color(0xFFE8E8EE),
                          tail: false,
                          isSender: !currMessage.is_sender,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.0.h,
                        );
                      },
                      itemCount: cubit.allMessages.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _controller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Message cannot be empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter yout message ....",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.sendUserMessage(
                                  message: _controller.text,
                                );
                                _controller.clear();
                              }
                            },
                            backgroundColor: Colors.blue,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
