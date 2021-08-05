import 'package:app_usage/app_usage.dart';

Future<List<AppUsageInfo>> getUsageStats(int i) async {
  try {
    if(i>0)
   {
     var now =DateTime.now();
     DateTime endDate = new DateTime(now.year,now.month,now.day-i+1);
     DateTime startDate = new DateTime(now.year,now.month,now.day-i);
     List<AppUsageInfo> infoList = await AppUsage.getAppUsage(startDate, endDate);
     return infoList;
   }
    var now =DateTime.now();
    DateTime endDate = new DateTime(now.year,now.month,now.day,now.hour,now.minute,now.second);
    DateTime startDate = new DateTime(now.year,now.month,now.day);
    List<AppUsageInfo> infoList = await AppUsage.getAppUsage(startDate, endDate);
    return infoList;

  } on AppUsageException catch (exception) {
    print(exception);
  }
}