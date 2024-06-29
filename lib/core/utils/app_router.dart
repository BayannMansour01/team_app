import 'package:go_router/go_router.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/appointments_page.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/appointements_details_body.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/appointments_body.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/chat_screen.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/conversations_screen.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:team_app/features/homepage/presentation/screens/home_page.dart';
import 'package:team_app/features/login_screen/login_screen.dart';
import 'package:team_app/features/splash/splash_view.dart';

abstract class AppRouter {
  static const kRegisterView = '/RegisterView';
  static const kLoginView = '/LoginView';
  static const khomeView = '/homeView';
  static const kProfileView = '/ProfileView';

  static const kAppointemntsView = '/AppointemntsView';

  static const kAppointemntsDetailesView = '/kAppointemntsDetailesView';

  static const kChatView = '/kChatView';

  static const kChatUserView = '/kChatUserView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: khomeView,
        builder: (context, state) => HomePage(
          token: CacheHelper.getData(key: 'Token'),
        ),
      ),
      GoRoute(
        path: kAppointemntsView,
        builder: (context, state) => AppointmentsScreen(),
      ),

      GoRoute(
        path: kAppointemntsDetailesView,
        builder: (context, state) => AppointementDetailsScreen(
          appointement: state.extra as Appointment,
        ),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => LoginView(),
      ),
      // GoRoute(
      //   path: kProfileView,
      //   builder: (context, state) => ProfileView(),
      // ),
      GoRoute(
        path: kChatView,
        builder: (context, state) => ConversationsScreen(),
      ),
      GoRoute(
        path: kChatUserView,
        builder: (context, state) => ChatScreen(user: state.extra as ChatUser),
      ),
    ],
  );
}
