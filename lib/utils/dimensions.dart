import 'package:get/get.dart';

class Dimensions {
  // static references height iphone
  static double heightRef = 844.0;
  static double widthRef = 390.0;

  // height and width of the screen
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // dynamic page view height
  static double hPageView100 = screenHeight / (heightRef / 100);
  static double hPageView120 = screenHeight / (heightRef / 120);
  static double hPageView150 = screenHeight / (heightRef / 150);
  static double hPageView220 = screenHeight / (heightRef / 220);
  static double hPageView320 = screenHeight / (heightRef / 320);
  static double hPageView420 = screenHeight / (heightRef / 420);
  static double hPageView520 = screenHeight / (heightRef / 520);
  static double hPageView620 = screenHeight / (heightRef / 620);
  static double hPageView720 = screenHeight / (heightRef / 720);
  static double hPageView820 = screenHeight / (heightRef / 820);
  static double hPageView920 = screenHeight / (heightRef / 920);
  static double hPageView1020 = screenHeight / (heightRef / 1020);

  // dynamic page view width
  static double wPageView100 = screenWidth / (widthRef / 100);
  static double wPageView120 = screenWidth / (widthRef / 120);
  static double wPageView150 = screenWidth / (widthRef / 150);
  static double wPageView220 = screenWidth / (widthRef / 220);
  static double wPageView320 = screenWidth / (widthRef / 320);
  static double wPageView420 = screenWidth / (widthRef / 420);
  static double wPageView520 = screenWidth / (widthRef / 520);
  static double wPageView620 = screenWidth / (widthRef / 620);
  static double wPageView720 = screenWidth / (widthRef / 720);
  static double wPageView820 = screenWidth / (widthRef / 820);
  static double wPageView920 = screenWidth / (widthRef / 920);
  static double wPageView1020 = screenWidth / (widthRef / 1020);

  // dynamic height padding and margin
  static double height1 = screenHeight / (heightRef / 1);
  static double height1_2 = screenHeight / (heightRef / 1.2);
  static double height1_5 = screenHeight / (heightRef / 1.5);
  static double height5 = screenHeight / (heightRef / 5);
  static double height10 = screenHeight / (heightRef / 10);
  static double height15 = screenHeight / (heightRef / 15);
  static double height20 = screenHeight / (heightRef / 20);
  static double height25 = screenHeight / (heightRef / 25);
  static double height30 = screenHeight / (heightRef / 30);
  static double height35 = screenHeight / (heightRef / 35);
  static double height40 = screenHeight / (heightRef / 40);
  static double height45 = screenHeight / (heightRef / 45);
  static double height50 = screenHeight / (heightRef / 50);
  static double height55 = screenHeight / (heightRef / 55);
  static double height60 = screenHeight / (heightRef / 60);
  static double height65 = screenHeight / (heightRef / 65);
  static double height70 = screenHeight / (heightRef / 70);
  static double height75 = screenHeight / (heightRef / 75);
  static double height80 = screenHeight / (heightRef / 80);
  static double height85 = screenHeight / (heightRef / 85);
  static double height90 = screenHeight / (heightRef / 90);
  static double height95 = screenHeight / (heightRef / 95);
  static double height100 = screenHeight / (heightRef / 100);

  // dynamic width padding and margin (844/10)
  static double width1 = screenHeight / (heightRef / 1);
  static double width1_2 = screenHeight / (heightRef / 1.2);
  static double width1_5 = screenHeight / (heightRef / 1.5);
  static double width5 = screenHeight / (heightRef / 5);
  static double width10 = screenHeight / (heightRef / 10);
  static double width15 = screenHeight / (heightRef / 15);
  static double width20 = screenHeight / (heightRef / 20);
  static double width25 = screenHeight / (heightRef / 25);
  static double width30 = screenHeight / (heightRef / 30);
  static double width35 = screenHeight / (heightRef / 35);
  static double width40 = screenHeight / (heightRef / 40);
  static double width45 = screenHeight / (heightRef / 45);
  static double width50 = screenHeight / (heightRef / 50);
  static double width55 = screenHeight / (heightRef / 55);
  static double width60 = screenHeight / (heightRef / 60);
  static double width65 = screenHeight / (heightRef / 65);
  static double width70 = screenHeight / (heightRef / 70);
  static double width75 = screenHeight / (heightRef / 75);
  static double width80 = screenHeight / (heightRef / 80);
  static double width85 = screenHeight / (heightRef / 85);
  static double width90 = screenHeight / (heightRef / 90);
  static double width95 = screenHeight / (heightRef / 95);
  static double width100 = screenHeight / (heightRef / 100);

  // dymanic font size
  static double font10 = screenHeight / (heightRef / 10);
  static double font11 = screenHeight / (heightRef / 11);
  static double font12 = screenHeight / (heightRef / 12);
  static double font13 = screenHeight / (heightRef / 13);
  static double font14 = screenHeight / (heightRef / 14);
  static double font15 = screenHeight / (heightRef / 15);
  static double font16 = screenHeight / (heightRef / 16);
  static double font17 = screenHeight / (heightRef / 17);
  static double font18 = screenHeight / (heightRef / 18);
  static double font19 = screenHeight / (heightRef / 19);
  static double font20 = screenHeight / (heightRef / 20);
  static double font25 = screenHeight / (heightRef / 25);
  static double font30 = screenHeight / (heightRef / 30);
  static double font35 = screenHeight / (heightRef / 35);
  static double font40 = screenHeight / (heightRef / 40);
  static double font45 = screenHeight / (heightRef / 45);
  static double font50 = screenHeight / (heightRef / 50);

  // dynamic raduis
  static double radius5 = screenHeight / (heightRef / 5);
  static double radius10 = screenHeight / (heightRef / 10);
  static double radius15 = screenHeight / (heightRef / 15);
  static double radius20 = screenHeight / (heightRef / 20);
  static double radius25 = screenHeight / (heightRef / 25);
  static double radius30 = screenHeight / (heightRef / 30);
  static double radius35 = screenHeight / (heightRef / 35);
  static double radius40 = screenHeight / (heightRef / 40);
  static double radius45 = screenHeight / (heightRef / 45);
  static double radius50 = screenHeight / (heightRef / 50);

  // dynamic icon size
  static double icon5 = screenHeight / (heightRef / 5);
  static double icon10 = screenHeight / (heightRef / 10);
  static double icon15 = screenHeight / (heightRef / 15);
  static double icon16 = screenHeight / (heightRef / 16);
  static double icon20 = screenHeight / (heightRef / 20);
  static double icon25 = screenHeight / (heightRef / 25);
  static double icon30 = screenHeight / (heightRef / 30);
  static double icon35 = screenHeight / (heightRef / 35);
  static double icon40 = screenHeight / (heightRef / 40);
  static double icon45 = screenHeight / (heightRef / 45);
  static double icon50 = screenHeight / (heightRef / 50);

  // dynamic image size
  static double img350 = screenHeight / (heightRef / 350);
}
