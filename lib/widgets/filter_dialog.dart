import 'package:buyer_app/global/responsive.dart';
import 'package:flutter/material.dart';

import '../providers/DashboardProvider.dart';

Future<dynamic> filterCardDialog(BuildContext context, DashboardProvider postMdl, int categoriesId) async {
  bool returnType = false;
  int selectedCategoriesId = categoriesId;
  await showDialog(
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return Dialog(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          backgroundColor: Colors.white,
          child: SizedBox(
            height: Responsive.height(65, context),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize : MainAxisSize.min,
                    children: [
            
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Categories",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                      ),
            
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
            
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount:
                            postMdl.categoriesModel?.data?.dishes?.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (){
                                  setState((){
                                    if(selectedCategoriesId == (postMdl.categoriesModel!.data!.dishes![index].id ?? 0)){
                                      selectedCategoriesId = 0;
                                    }else{
                                      selectedCategoriesId=postMdl.categoriesModel!.data!.dishes![index].id ?? 0 ;
                                    }
            
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 0),
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: postMdl.categoriesModel!.data!.dishes![index].id == selectedCategoriesId ? Colors.green : Colors.transparent,
                                              border: Border.all(color: postMdl.categoriesModel!.data!.dishes![index].id == selectedCategoriesId ? Colors.green : Colors.grey),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: postMdl.categoriesModel!.data!.dishes![index].id == selectedCategoriesId ? const Icon(Icons.check_rounded, color: Colors.white, size: 16) : Container(),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            alignment: Alignment.center,
                                            child:  Text(
                                              "${postMdl.categoriesModel!.data!.dishes![index].foodcategory.toString()} (${postMdl.categoriesModel!.data!.dishes![index].count.toString()})",
                                              // popularFoodCategoriesList[index].foodName!,
                                              textAlign: TextAlign.center, style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,),),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
            
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all( const BorderSide(width: 1.0, color: Colors.orange)),
                                  backgroundColor: MaterialStateProperty.all(Colors.white ),
                                  elevation: MaterialStateProperty.all(0),
                                  foregroundColor: MaterialStateProperty.all(Colors.transparent),
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),),),
                                onPressed: () async {
                                  returnType = false;
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Reset',
                                      style: TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.orange ),
                                    elevation: MaterialStateProperty.all(0),
                                    foregroundColor: MaterialStateProperty.all(Colors.transparent),
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),)
                                ),
                                onPressed: () async {
                                  returnType = true;
                                  Navigator.pop(context);
                                },
                                child:   const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child:
                                    Text(
                                      'Apply',
                                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ));
    },
    // transitionDuration: const Duration(milliseconds: 300),
    barrierDismissible: false,
    barrierLabel: '',
    context: context,
    // pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    //   return const Text('');
    // }
  );

  return {"applied": returnType, "category_id": selectedCategoriesId};
}