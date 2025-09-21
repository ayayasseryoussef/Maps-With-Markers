# Live Tracking App (OSM + Supabase + GetX)

A real-time location tracking app using **OpenStreetMap**, **Supabase**, and **GetX** in Flutter. Users can see each other's location live with markers and a connecting polyline.

---

## Features

- Real-time location tracking between two users
- OpenStreetMap (OSM) integration
- GetX state management for reactive updates
- Supabase backend for storing and streaming user locations
- Polyline drawn between users
- Cross-platform: Android, iOS, Web, Desktop
- Web optimization using `CancellableTileProvider`

---

## Dependencies

- `flutter_map: ^7.0.2`
- `latlong2`
- `get`
- `supabase_flutter`
- `flutter_map_cancellable_tile_provider: ^3.0.2` (for Web performance)
- `flutter/foundation` (for `kIsWeb` detection)

---

## Project Structure

lib/
├── controllers/
│ └── location_controller.dart # GetX controller for tracking locations
├── services/
│ └── supabase_service.dart # Supabase client and methods
├── views/
│ └── map_view.dart # FlutterMap UI with markers and polyline
└── main.dart # App entry point

yaml
Copy code

---

## Supabase Setup

1. Create a Supabase project at [https://supabase.com](https://supabase.com)
2. Create a table called `locations` with the following columns:
   - `id` (text, primary key) → user identifier
   - `created_at` (timestamp, default: now())
   - `lat` (decimal/float)
   - `lng` (decimal/float)
3. Enable **Realtime** for the `locations` table.
4. Optionally, configure **RLS (Row Level Security)** policies for more secure updates.

---
:

Blue marker → current user

Red marker → other user

Polyline drawn if both locations exist




How it Works

Each device updates its location to Supabase (myLocation)

Each device listens to Supabase realtime for other users (otherLocation)

FlutterMap automatically updates markers and polyline via GetX reactive state

Web performance is optimized with cancellable tiles to reduce loading overhead
Ensure location permissions are granted on mobile devices.

For real-time updates, each device must be sending its location continuously.

Polyline connects the two users to visually represent their distance.