
import '../types/app_release.dart';

extension AppReleaseExtension on List<AppRelease> {
  void sortVersion({bool isNewest=true}){
    sort((a,b){
      // to top newest
      if(isNewest){
        return b.version.compareTo(a.version);
      }else{
        //to top oldest
        return a.version.compareTo(b.version);
      }
    });
  }
}