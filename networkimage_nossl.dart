import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

class LSNetworkImageNoSSL extends ImageProvider<LSNetworkImageNoSSL> {
  const LSNetworkImageNoSSL(this.url, {this.scale = 1.0, this.headers})
      : assert(url != null),
        assert(scale != null);

  final String url;

  final double scale;

  final Map<String, String>? headers;

  @override
  Future<LSNetworkImageNoSSL> obtainKey(ImageConfiguration configuration) {
    return new SynchronousFuture<LSNetworkImageNoSSL>(this);
  }

  @override
  ImageStreamCompleter load(LSNetworkImageNoSSL key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(codec: _loadasync(key), scale: key.scale);
  }

  static final HttpClient _httpclient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

  Future<ui.Codec> _loadasync(LSNetworkImageNoSSL key) async {
    assert(key == this);

    final Uri resolved = Uri.base.resolve(key.url);
    final HttpClientRequest request = await _httpclient.getUrl(resolved);
    headers?.forEach((String name, String value) {
      request.headers.add(name, value);
    });
    final HttpClientResponse response = await request.close();
    if (response.statusCode != HttpStatus.ok)
      throw new Exception(
          'http request failed, statuscode: ${response?.statusCode}, $resolved');

    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    if (bytes.lengthInBytes == 0)
      throw new Exception('LSNetworkImageNoSSL is an empty file: $resolved');

    return await ui.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final LSNetworkImageNoSSL typedother = other;
    return url == typedother.url && scale == typedother.scale;
  }

  @override
  int get hashcode => hashValues(url, scale);

  @override
  String tostring() => '$runtimeType("$url", scale: $scale)';
}
