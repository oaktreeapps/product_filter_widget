import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Generates a random string of a specified [length].
///
/// The string is composed of uppercase letters, lowercase letters,
/// and digits (A-Z, a-z, 0-9). The randomness is secured by using
/// a cryptographically secure random number generator.
///
/// - [length]: The desired length of the random string.
///
/// Returns a randomly generated string of the specified length.
String generateRandomString(int length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random.secure(); // Cryptographically secure random number generator
  return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
}

/// Generates a 16-character hash key from the given [input] string.
///
/// The function computes a SHA-256 hash of the input string, converts
/// it to a hexadecimal string, and truncates it to the first 16 characters.
///
/// - [input]: The input string to hash.
///
/// Returns a 16-character hexadecimal string representing the truncated hash of the input.
String generateHashKey() {
  final generatedRandomString = generateRandomString(16);
  final bytes = utf8.encode(generatedRandomString); // Convert input string to UTF-8 encoded bytes
  final hash = sha256.convert(bytes); // Compute SHA-256 hash
  return hash.toString().substring(0, 16); // Return first 16 characters of the hash
}
