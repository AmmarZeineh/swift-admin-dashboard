import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as b;
import 'package:swift_web_admin_dashboard/app_keys.dart';
import 'package:swift_web_admin_dashboard/core/services/backend_endpoints.dart';
import 'package:swift_web_admin_dashboard/core/services/storage_service.dart';


class SupabaseStorageService extends StorageService {
  SupabaseClient supabase = SupabaseClient(AppKeys.url, AppKeys.annon);

  @override
  Future<String> uploadFile(File file, String path) async {
    var fileName = b.basename(file.path);
    await supabase.storage
        .from(BackendEndpoints.images)
        .upload('$path/$fileName', file);
    var url = supabase.storage
        .from(BackendEndpoints.images)
        .getPublicUrl('$path/$fileName');
    return url;
  }
}
