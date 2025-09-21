// ignore_for_file: depend_on_referenced_packages

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Future<void> updateLocation(String userId, double lat, double lng) async {
    await client.from('locations').upsert({
      'id': userId,
      'lat': lat,
      'lng': lng,
    }, onConflict: 'id'); 
  }

  RealtimeChannel listenToOtherUser(
      String otherId, Function(Map<String, dynamic>) onChange) {
    final channel = client.channel('public:locations');
    channel.on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: 'UPDATE',
        schema: 'public',
        table: 'locations',
        filter: 'id=eq.$otherId',
      ),
      (payload, [ref]) {
        onChange(payload['new']);
      },
    );
    channel.subscribe();
    return channel;
  }
}
