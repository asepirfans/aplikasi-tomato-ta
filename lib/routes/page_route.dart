import 'package:get/get.dart';
import 'package:tomato_farm/pages/images/allImage.dart';
import 'package:tomato_farm/pages/loginPage.dart';
import 'package:tomato_farm/pages/registerPage.dart';
import 'route_name.dart';
import '../pages/homePage.dart';
import '../pages/monitoringDetailPages/monitoringDetailPagePlant1.dart';
import '../pages/monitoringDetailPages/monitoringDetailPagePlant2.dart';
import '../pages/monitoringDetailPages/monitoringDetailPagePlant3.dart';
import '../pages/monitoringPage.dart';
import '../pages/detect.dart';
import '../pages/detect_page.dart';
import '../pages/pumpPage.dart';
import '../pages/images/imagePage.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: RouteName.monitoringPage,
      page: () => MonitoringPage(),
    ),
    GetPage(
      name: RouteName.monitoringDetailPagePlant1,
      page: () => MonitoringDetailPagePlant1(),
    ),
    GetPage(
      name: RouteName.monitoringDetailPagePlant2,
      page: () => MonitoringDetailPagePlant2(),
    ),
    GetPage(
      name: RouteName.monitoringDetailPagePlant3,
      page: () => MonitoringDetailPagePlant3(),
    ),
    GetPage(
      name: RouteName.detect,
      page: () => DetectPage(),
    ),
    GetPage(
      name: RouteName.detectPage,
      page: () => Detect(),
    ),
    GetPage(
      name: RouteName.pumpPage,
      page: () => PumpPage(),
    ),
    GetPage(
      name: RouteName.register,
      page: () => RegisterView(),
    ),
    GetPage(
      name: RouteName.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteName.image,
      page: () => ImageDisplay(
        imageId: '660e743bbda5ffcf2a69159a',
      ),
    ),
    GetPage(
      name: RouteName.allImage,
      page: () => AllImagesDisplay(),
    ),
  ];
}
