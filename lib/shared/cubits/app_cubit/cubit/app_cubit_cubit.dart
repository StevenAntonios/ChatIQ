import 'package:bloc/bloc.dart';
import 'package:chat_iq/index.dart';
import 'package:chat_iq/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';

part 'app_cubit_state.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit() : super(AppCubitInitial());
  static AppCubitCubit get(context) => BlocProvider.of(context);
  int currentChatId = 0;
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;
  void getCurrentChatId() {
    if (_auth.currentUser != null) {
      _database
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("chats")
          .snapshots()
          .listen((event) {
        if (currentChatId != 0) {
          if (event.docs.isNotEmpty) {
            currentChatId = event.docs.length;
          } else {
            currentChatId++;
          }
        }
        emit(GetChatIdSuccessfully());
      }).onError((error) {
        emit(GetChatIdError());
      });
    }
  }

  void sendUserMessage({required String message}) {
    MessageModel messageModel = MessageModel(
      content: message,
      time: Timestamp.now(),
      is_sender: false,
      media: null,
    );
    _database
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("chats")
        .doc(currentChatId.toString())
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessfully());

      getGeminiResponse(prom: message).then((value) {
        messageModel = MessageModel(
            content: value!,
            time: Timestamp.now(),
            is_sender: true,
            media: null);
        _database
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("chats")
            .doc(currentChatId.toString())
            .collection("messages")
            .add(messageModel.toMap())
            .then((v) {
          emit(SendMessageSuccessfully());
        }).catchError((error) {
          emit(SendMessageWithError());
        });
      }).catchError((error) {
        emit(SendMessageWithError());
      });
    }).catchError((error) {
      emit(SendMessageWithError());
    });
  }

  Future<String?> getGeminiResponse({required String prom}) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "AIzaSyDXwIL5W42_zLK89p1yJCfYtNTH-yBD2C0",
    );

    final content = [Content.text(prom)];
    final response = await model.generateContent(content);

    return response.text;
  }

  List<MessageModel> allMessages = [];
  void getAllMessage() {
    String myId = _auth.currentUser!.uid;
    emit(GetAllMessagesLoading());
    _database
        .collection("users")
        .doc(myId)
        .collection("chats")
        .doc(currentChatId.toString())
        .collection("messages")
        .orderBy("time")
        .snapshots()
        .listen((event) {
      allMessages = [];
      for (var element in event.docs) {
        print(element.data());
        allMessages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetAllMessagesSuccessfully());
    });
  }
}
