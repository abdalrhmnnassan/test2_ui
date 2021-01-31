
import 'package:storeaksdk/models/GPS/LocationsList.dart';
import 'package:storeaksdk/models/result_classes.dart';
import 'package:storeaksdk/services/StoreakSDKService.dart';
// this function to getLocation.
Future getLocation() async{
  ResponseState<LocationsList> data = await StoreakSdkService().gpsService.getLocations();
  return data;
}
// fetch data from api
Future getlocations() async{
  var body = await getLocation();// to store Locations List

  if (body is SuccessState<LocationsList> ) {
    var locationModel = body.data;
    return {'bool':true,'result':locationModel};
  }
}