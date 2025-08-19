// import 'package:auto_route/auto_route.dart';
// import 'package:common/common.dart';
// import 'package:flutter/material.dart';

// @RoutePage()

// /// [DashboardWrapperView] is a class that contains the dashboard wrapper view.
// final class DashboardWrapperView extends StatefulWidget {
//   /// Constructor
//   const DashboardWrapperView({super.key});

//   @override
//   State<DashboardWrapperView> createState() => _DashboardWrapperViewState();
// }

// class _DashboardWrapperViewState extends State<DashboardWrapperView> {
//   @override
//   Widget build(BuildContext context) {
//     return AutoTabsRouter(
//       routes: const [
//         HomeRoute(),
//         ProfileWrapperRoute(),
//       ],
//       builder: (context, child) {
//         return Scaffold(
//           body: child,
//           bottomNavigationBar: BottomNavigationBar(
//             items: [
//               BottomNavigationBarItem(
//                 icon: _CustomBottomNavigationBarItem(
//                     iconData: Icons.home, tabName: TabName.home.name),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: _CustomBottomNavigationBarItem(
//                     iconData: Icons.person, tabName: TabName.profile.name),
//                 label: '',
//               ),
//             ],
//             currentIndex: context.tabsRouter.activeIndex,
//             onTap: (index) {
//               context.tabsRouter.setActiveIndex(index);
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// /// [_CustomBottomNavigationBarItem] is a custom widget for the bottom navigation bar item.
// final class _CustomBottomNavigationBarItem extends StatelessWidget {
//   const _CustomBottomNavigationBarItem({
//     required this.iconData,
//     required this.tabName,
//   });

//   final IconData iconData;
//   final String tabName;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           vertical: context.deviceHeight * 0.01,
//           horizontal: context.deviceWidth * 0.05),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadiusManager.moreBorderRadius,
//         border: Border.all(
//           color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
//           width: context.deviceWidth * 0.0015,
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(iconData),
//           Text(
//             tabName,
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   fontWeight: FontWeight.w500,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
