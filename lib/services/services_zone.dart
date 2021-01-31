import 'package:storeaksdk/models/GPS/ZoneModelList.dart';
import 'package:storeaksdk/models/result_classes.dart';
import 'package:storeaksdk/services/StoreakSDKService.dart';
// this function to get Zone.
Future getZone() async{
  ResponseState<ZoneModelList> data = await StoreakSdkService().gpsService.getDeliveryZones();
  return data;
}
// fetch data from api
Future getZones() async{
  var body = await getZone();// to store Locations List

  if (body is SuccessState<ZoneModelList> ) {
    var zoneModel = body.data;
    return {'bool':true,'result':zoneModel};
  }
}