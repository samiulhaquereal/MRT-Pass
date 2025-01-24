import 'dart:typed_data';

// ByteParser equivalent in Dart
class ByteParser {
  static String toHexString(Uint8List bytes) {
    return bytes.map((byte) {
      // Format byte to hex
      return byte.toRadixString(16).padLeft(2, '0').toUpperCase();
    }).join(' ');
  }

  static int extractInt16(Uint8List bytes, int offset) {
    return ((bytes[offset + 1] & 0xFF) << 8) | (bytes[offset] & 0xFF);
  }

  static int extractInt24(Uint8List bytes, int offset) {
    return ((bytes[offset + 2] & 0xFF) << 16) |
    ((bytes[offset + 1] & 0xFF) << 8) |
    (bytes[offset] & 0xFF);
  }

  static int extractByte(Uint8List bytes, int offset) {
    return bytes[offset] & 0xFF;
  }

  static int extractInt24BigEndian(Uint8List bytes, int offset) {
    return ((bytes[offset] & 0xFF) << 16) |
    ((bytes[offset + 1] & 0xFF) << 8) |
    (bytes[offset + 2] & 0xFF);
  }
}