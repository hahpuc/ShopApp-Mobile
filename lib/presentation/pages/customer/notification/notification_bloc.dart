import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/data/app_repository.dart';
import 'package:furniture_shop/data/model/response/notification_response.dart';
import 'package:furniture_shop/presentation/pages/customer/notification/notification_state.dart';

class NotificationPageBloc extends BlocBase<NotificationPageState> {
  final AppRepository appRepository;

  NotificationPageBloc({required this.appRepository})
      : super(NotificationPageState());

  Future<void> loadData(int page) async {
    // emit(NotificationPageLoadingState());

    await Future.delayed(Duration(seconds: 1));

    List<NotificationResponseData> notification = [
      NotificationResponseData(
          userId: 6,
          title: "Long 1",
          image:
              "http://res.cloudinary.com/dynk5q1io/image/upload/v1634120352/products/Gaming%20Table/axmlvoybwtp7xekzz6eq.jpg",
          message:
              "Donec ut mauris eget massa tempor convallis. Nulla neque libero, ",
          seen: true),
      NotificationResponseData(
          userId: 89,
          title: "Long 2",
          image: "http://dummyimage.com/70x70.png/cc0000/ffffff",
          message:
              "Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. ",
          seen: false),
      NotificationResponseData(
          userId: 88,
          title: "Long 3",
          image: "http://dummyimage.com/70x70.png/ff4444/ffffff",
          message:
              "Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ",
          seen: false),
      NotificationResponseData(
          userId: 59,
          title: "Long 4",
          image: "http://dummyimage.com/70x70.png/cc0000/ffffff",
          message: "Duis consequat dui nec nisi volutpat eleifend.",
          seen: true),
      NotificationResponseData(
          userId: 81,
          title: "Long 5",
          image: "http://dummyimage.com/70x70.png/dddddd/000000",
          message:
              "In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, ",
          seen: false),
      NotificationResponseData(
          userId: 59,
          title: "Long 6",
          image: "http://dummyimage.com/70x70.png/5fa2dd/ffffff",
          message:
              "Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.",
          seen: false),
      NotificationResponseData(
          userId: 60,
          title: "Long 7",
          image: "http://dummyimage.com/70x70.png/ff4444/ffffff",
          message: "Nulla tempus.",
          seen: true),
      NotificationResponseData(
          userId: 40,
          title: "Long 8",
          image: "http://dummyimage.com/70x70.png/5fa2dd/ffffff",
          message:
              "Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.",
          seen: false),
      NotificationResponseData(
          userId: 68,
          title: "Long 9",
          image: "http://dummyimage.com/70x70.png/ff4444/ffffff",
          message:
              "Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae",
          seen: false),
      NotificationResponseData(
          userId: 82,
          title: "Long 10",
          image: "http://dummyimage.com/70x70.png/ff4444/ffffff",
          message:
              "Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.",
          seen: false),
      NotificationResponseData(
          userId: 62,
          title: "Long 11",
          image: "http://dummyimage.com/70x70.png/ff4444/ffffff",
          message:
              "Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.",
          seen: true),
      NotificationResponseData(
          userId: 92,
          title: "Long 12",
          image: "http://dummyimage.com/70x70.png/ff4444/ffffff",
          message:
              "Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.",
          seen: false),
      NotificationResponseData(
          userId: 1,
          title: "Long 13",
          image: "http://dummyimage.com/70x70.png/ff4444/ffffff",
          message:
              "Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.",
          seen: false),
      NotificationResponseData(
          userId: 41,
          title: "Long 14",
          image: "http://dummyimage.com/70x70.png/dddddd/000000",
          message:
              "Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.",
          seen: true),
      NotificationResponseData(
          userId: 51,
          title: "Long 15",
          image:
              "http://res.cloudinary.com/dynk5q1io/image/upload/v1634120357/products/Gaming%20Table/g9xxtp6mtfdmh00kosmt.jpg",
          message:
              "Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. ",
          seen: false)
    ];

    emit(NotificationPageGetDataSuccessState(
      page: page,
      totalPages: 10,
      data: notification,
    ));
  }
}
