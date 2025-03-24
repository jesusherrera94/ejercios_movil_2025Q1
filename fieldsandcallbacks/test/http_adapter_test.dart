// filepath: lib/adapters/http_adapter_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:fieldsandcallbacks/adapters/http_adapter.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'dart:convert';

@GenerateMocks([http.Client])
import 'http_adapter_test.mocks.dart';

void main() {
  group('HttpAdapter', () {
    late MockClient mockClient;
    late HttpAdapter httpAdapter;

    setUp(() {
      mockClient = MockClient();
      httpAdapter = HttpAdapter(client: mockClient);
    });

    tearDown(() {
      reset(mockClient); // Reset the mock after each test
    });

    test('getRequest returns response body when the call completes successfully', () async {
      // Arrange
      const mockResponseBody = '[{"id":1,"type":"general","setup":"Why did the chicken cross the road?","punchline":"To get to the other side!"}]';
      Uri url = Uri.https("official-joke-api.appspot.com", "/random_ten");

      when(mockClient.get(url)).thenAnswer(
        (_) async => http.Response(mockResponseBody, 200),
      );

      // Act
      final result = await httpAdapter.getRequest();

      // Assert
      expect(result, mockResponseBody);
    });

    test('getRequest throws an exception when the call fails', () async {
      // Arrange
      Uri url = Uri.https("official-joke-api.appspot.com", "/random_ten");

      when(mockClient.get(url)).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      // Act & Assert
      expect(() async => await httpAdapter.getRequest(), throwsException);
    });
  });
}