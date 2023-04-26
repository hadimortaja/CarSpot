// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:developer';

import 'package:car_rental/features/car_ad_sale_view/data/data_sources/get_product_by_id_data_source.dart';
import 'package:car_rental/features/car_ad_sale_view/presentation/views/car_ad_sale_view.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

    import 'package:share_plus/share_plus.dart';

class DynamicLinkService {

  Future<void> retrieveDynamicLink() async {
    try {
      // final PendingDynamicLinkData data =
      //     await FirebaseDynamicLinks.instance.getInitialLink();
      Timer(Duration(seconds: 2), () async {
        final PendingDynamicLinkData? data =
            await FirebaseDynamicLinks.instance.getInitialLink();
        log('data $data');
        try {
          if (data != null) {
            if (data.link != null ) {

              log('ffff ${data.link.queryParameters}');
              if (data.link.queryParameters.containsKey('idcar')) {
                String? id = data.link.queryParameters['idcar'];
                getProductById(id.toString());
                Get.to(()=>CarAdSaleView(id: id.toString(),));
                log('id $id');



            }}
          }
        } catch (e) {
          log('No deepLink found1');
        }
      });
      FirebaseDynamicLinks.instance.onLink.listen((deepLink) {
        // if (deepLink != null && !appController.flagDL) {

        if (deepLink != null) {
           log('ffff ${deepLink.link.queryParameters}');
          if (deepLink.link.queryParameters.containsKey('idcar')) {
            String? id = deepLink.link.queryParameters['idcar'];
            getProductById(id.toString());
 Get.to(()=>CarAdSaleView(id: id.toString(),));
            log('id $id');



        }}
      }).onError((error) {
        // Handle errors
      });
    } catch (e) {
      print(e.toString());
    }
  }

//keys =>idPost, idProduct ,
  Future<Uri> createDynamicLink({
    String? id,
    String? key,
    String? type,
    String? title,
    String? description,
    String? imageUrl,
  }) async {
    DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: 'https://cardeal.page.link',
      link:
           Uri.parse('https://cardeal.page.lin.com/?idcar=$id'),
       androidParameters:
          const AndroidParameters(packageName: "com.application.cardeal"),
      iosParameters: const IOSParameters(bundleId: "com.application.cardeal"),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(imageUrl!),
      ),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

    Uri url;

    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    url = shortLink.shortUrl;

    await Share.share(url.toString(), subject: 'Look what I made!');

    return dynamicLink;
  }
}
