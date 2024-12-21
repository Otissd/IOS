import 'dart:convert';
import 'package:http/http.dart' as http;

class LyricsProvider {
  final String baseUrl = "https://apic-desktop.musixmatch.com/ws/1.1";
  final Map<String, String> headers = {
    "authority": "apic-desktop.musixmatch.com",
    "cookie": "x-mxm-token-guid=",
  };
  final String userToken = "CONFIG.providers.musixmatch.token";

  Future<Map<String, dynamic>?> findLyrics(Map<String, dynamic> info) async {
    try {
      final double durationSeconds = info['duration'] / 1000;

      final Map<String, dynamic> params = {
        "q_album": info['album'],
        "q_artist": info['artist'],
        "q_artists": info['artist'],
        "q_track": info['title'],
        "track_spotify_id": info['uri'],
        "q_duration": durationSeconds,
        "f_subtitle_length": durationSeconds.floor(),
        "usertoken": userToken,
      };

      final uri = Uri.parse("$baseUrl/macro.subtitles.get?format=json&namespace=lyrics_richsynched&subtitle_format=mxm&app_id=web-desktop-app-v1.0&")
          .replace(queryParameters: params);

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final macroCalls = body['message']['body']['macro_calls'];
        
        if (macroCalls["matcher.track.get"]["message"]["header"]["status_code"] != 200) {
          return {"error": "Requested error", "uri": info['uri']};
        }
        
        if (macroCalls["track.lyrics.get"]["message"]["body"]?["lyrics"]?["restricted"] == true) {
          return {"error": "Unfortunately we're not authorized to show these lyrics.", "uri": info['uri']};
        }

        return macroCalls;
      } else {
        throw Exception("Failed to fetch lyrics");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getKaraoke(Map<String, dynamic> body) async {
    try {
      final meta = body["matcher.track.get"]["message"]["body"];
      if (meta == null || !meta["track"]["has_richsync"] || meta["track"]["instrumental"]) {
        return null;
      }

      final Map<String, dynamic> params = {
        "f_subtitle_length": meta["track"]["track_length"],
        "q_duration": meta["track"]["track_length"],
        "commontrack_id": meta["track"]["commontrack_id"],
        "usertoken": userToken,
      };

      final uri = Uri.parse("$baseUrl/track.richsync.get?format=json&subtitle_format=mxm&app_id=web-desktop-app-v1.0&")
          .replace(queryParameters: params);

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final result = json.decode(response.body)['message']['body'];
        final List parsedKaraoke = json.decode(result['richsync']['richsync_body']);
        return parsedKaraoke.map((line) {
          final int startTime = (line['ts'] * 1000).toInt();
          final List<Map<String, dynamic>> words = (line['l'] as List).map((word) {
            return {
              "word": word["c"],
              "time": word["o"] * 1000,
            };
          }).toList();

          return {"startTime": startTime, "text": words};
        }).toList();
      } else {
        throw Exception("Failed to fetch karaoke");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getSynced(Map<String, dynamic> body) async {
    final meta = body["matcher.track.get"]["message"]["body"];
    if (meta == null || meta["track"]["instrumental"]) {
      return [{"text": "♪ Instrumental ♪", "startTime": "0000"}];
    }

    if (meta["track"]["has_subtitles"] == true) {
      final subtitle = body["track.subtitles.get"]["message"]["body"]?["subtitle_list"]?[0]?["subtitle"];
      if (subtitle == null) return null;

      return (json.decode(subtitle["subtitle_body"]) as List).map((line) {
        return {"text": line["text"] ?? "♪", "startTime": line["time"]["total"] * 1000};
      }).toList();
    }

    return null;
  }

  Future<List<Map<String, String>>?> getUnsynced(Map<String, dynamic> body) async {
    final meta = body["matcher.track.get"]["message"]["body"];
    if (meta == null || meta["track"]["instrumental"]) {
      return [{"text": "♪ Instrumental ♪"}];
    }

    if (meta["track"]["has_lyrics"] == true || meta["track"]["has_lyrics_crowd"] == true) {
      final lyrics = body["track.lyrics.get"]["message"]["body"]?["lyrics"]?["lyrics_body"];
      if (lyrics == null) return null;

      return lyrics.split("\n").map((line) => {"text": line}).toList();
    }

    return null;
  }
}
