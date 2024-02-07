import 'package:yebelo_test/consts/color_pallet.dart';
import 'package:yebelo_test/consts/const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                //category section

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Consumer<HomeController>(
                      builder: (context, controller, x) {
                    return Row(
                      children: List.generate(
                        controller.categories.length,
                        (index) => "${controller.categories[index]}"
                            .text
                            .color(controller.selectedCategoryIndex == index
                                ? Colors.white
                                : Colors.black)
                            .size(16)
                            .make()
                            .box
                            .color(controller.selectedCategoryIndex == index
                                ? greenColor
                                : Colors.white)
                            .border(
                                color: controller.selectedCategoryIndex == index
                                    ? greenColor
                                    : Colors.grey.shade400)
                            .padding(const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10))
                            .roundedSM
                            .make()
                            .marginSymmetric(horizontal: 5)
                            .onTap(() {
                          controller.selectCategory = index;
                          controller
                              .filterProducts(controller.categories[index]);
                        }),
                      ),
                    );
                  }),
                ),
                20.heightBox,

                //Products List
                Expanded(
                  child: Consumer<HomeController>(
                      builder: (context, controller, x) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: greyBgColor,
                      ),
                      padding: EdgeInsets.all(0),
                      itemCount: controller.productsList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Image.asset(
                              controller.productsList[index]['p_image'],
                              fit: BoxFit.fill,
                              width: 120,
                              height: 120,
                            ),
                            20.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${controller.productsList[index]['p_name']}"
                                      .text
                                      .size(18)
                                      .semiBold
                                      .make(),
                                  10.heightBox,
                                  "${controller.productsList[index]['p_details']}"
                                      .text
                                      .size(16)
                                      .make(),
                                  10.heightBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "₹ ${controller.productsList[index]['p_cost']}"
                                          .text
                                          .size(20)
                                          .fontFamily(semiBold)
                                          .color(priceTextColor)
                                          .make(),
                                      controller.productsList[index]['p_qty'] ==
                                              0
                                          ? "Add"
                                              .text
                                              .size(16)
                                              .white
                                              .make()
                                              .box
                                              .roundedSM
                                              .padding(
                                                EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5),
                                              )
                                              .color(greenColor)
                                              .make()
                                              .onTap(() {
                                              controller.updateQty(() {
                                                controller.productsList[index]
                                                    ['p_qty']++;
                                                controller.cart_items++;
                                              });
                                            })
                                          : Row(
                                              children: [
                                                Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ).onTap(() {
                                                  controller.updateQty(() {
                                                    controller
                                                            .productsList[index]
                                                        ['p_qty']--;
                                                    controller.cart_items--;
                                                  });
                                                }),
                                                10.widthBox,
                                                "${controller.productsList[index]['p_qty']}"
                                                    .text
                                                    .size(16)
                                                    .white
                                                    .make(),
                                                10.widthBox,
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ).onTap(() {
                                                  controller.updateQty(() {
                                                    controller
                                                            .productsList[index]
                                                        ['p_qty']++;
                                                    controller.cart_items++;
                                                  });
                                                })
                                              ],
                                            )
                                              .box
                                              .color(greenColor)
                                              .padding(
                                                EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5),
                                              )
                                              .roundedSM
                                              .make()
                                    ],
                                  ).paddingOnly(right: 20)
                                ],
                              ),
                            )
                          ],
                        ).paddingAll(12);
                      },
                    );
                  }),
                )
              ],
            ).box.make(),
          ),

          //submit button
          Consumer<HomeController>(builder: (context, controller, xxx) {
            return controller.cart_items > 0
                ? SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                scrollable: true,
                                content: Text(
                                  jsonEncode(controller.productsList),
                                ),
                              );
                            },
                          );
                        },
                        child: "Check Out"
                            .text
                            .fontFamily(semiBold)
                            .size(16)
                            .make()),
                  ).marginOnly(bottom: 30, left: 20, right: 20)
                : const SizedBox();
          })
        ],
      ),
    );
  }
}
