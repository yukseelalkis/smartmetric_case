// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// im
// part 'app_router.gr.dart';

// @AutoRouterConfig(replaceInRouteName: 'View,Route')

// /// [AppRouter] is the root router for the application.
// final class AppRouter extends RootStackRouter {
//   @override
//   List<AutoRoute> get routes => [
//         AutoRoute(
//           page: SplashRoute.page,
//           initial: true,
//         ),
//         AutoRoute(
//           page: AuthWrapperRoute.page,
//           children: [
//             AutoRoute(page: LoginRoute.page, initial: true),
//             AutoRoute(page: SignUpRoute.page),
//           ],
//         ),
//         AutoRoute(
//           page: DashboardWrapperRoute.page,
//           children: [
//             AutoRoute(page: HomeRoute.page, initial: true),
//             AutoRoute(
//               page: ProfileWrapperRoute.page,
//               children: [
//                 AutoRoute(page: ProfileRoute.page, initial: true),
//                 AutoRoute(page: AddingProfilePhotoRoute.page),
//               ],
//             ),
//           ],
//         ),
//       ];
// }