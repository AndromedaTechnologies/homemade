import 'package:geolocator/geolocator.dart';
import 'package:permission/permission.dart';

class LocationPermission {

  getLocationPermission() async {
    var permissions =
        await Permission.getPermissionsStatus([PermissionName.Location]);
    bool permissionAllow = false;
    permissions.forEach((permission) {
      if (permission.permissionStatus == PermissionStatus.allow)
        permissionAllow = true;
    });

    if (!permissionAllow) {
      var permissionNames =
          await Permission.requestPermissions([PermissionName.Location]);
      permissionNames.forEach((permis) {
        if (permis.permissionStatus == PermissionStatus.allow) {
          permissionAllow = true;
//          geoLocatorPermission();
        }
      });
    }

    var permissionsCheck =
        await Permission.getPermissionsStatus([PermissionName.Location]);
    bool permissionAllowCheck = false;
    permissionsCheck.forEach((permission) {
      if (permission.permissionStatus == PermissionStatus.allow)
        permissionAllowCheck = true;
    });

    return geoLocatorPermission();

  }

  geoLocatorPermission() async {
    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager = true;
    return !(await geolocator.isLocationServiceEnabled());

  }
}
