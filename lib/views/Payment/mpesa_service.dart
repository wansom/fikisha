import 'dart:convert';
import 'package:http/http.dart' as http;

class MpesaService {
  final String consumerKey;
  final String consumerSecret;

  MpesaService(this.consumerKey, this.consumerSecret);

  // Function to initiate M-Pesa payment
  Future<String> initiatePayment(String phoneNumber, double amount) async {
    // Obtain OAuth access token
    final String accessToken = await _getAccessToken();

    // API endpoint to initiate payment
    const String paymentEndpoint = 'https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest';

    // Generate a random transaction reference (you may use a more specific logic)
    final String transactionReference = 'REF${DateTime.now().millisecondsSinceEpoch}';

    // Prepare request payload
    final Map<String, dynamic> payload = {
      'BusinessShortCode': '174379',
      'Password': _generatePassword(),
      'Timestamp': _generateTimestamp(),
      'TransactionType': 'CustomerPayBillOnline',
      'Amount': amount.toString(),
      'PartyA': phoneNumber,
      'PartyB': '174379',
      'PhoneNumber': phoneNumber,
      'CallBackURL': 'YOUR_CALLBACK_URL',
      'AccountReference': transactionReference,
      'TransactionDesc': 'Payment for delivery', // Customize as needed
    };

    // Make the API request
    final http.Response response = await http.post(
      Uri.parse(paymentEndpoint),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // Process the API response as needed and return the response message
      return responseData['ResponseDescription'];
    } else {
      // Handle the API error case
      throw Exception('Failed to initiate payment: ${response.body}');
    }
  }

  // Function to obtain OAuth access token
  Future<String> _getAccessToken() async {
    // API endpoint to get access token
    const String tokenEndpoint = 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';

    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}';

    final http.Response response = await http.get(
      Uri.parse(tokenEndpoint),
      headers: {'Authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['access_token'];
    } else {
      // Handle the API error case
      throw Exception('Failed to get access token: ${response.body}');
    }
  }

  // Helper function to generate password for API request
  String _generatePassword() {
    final String timestamp = _generateTimestamp();
    const String passkey = 'YOUR_LNM_PASSKEY';
    const String shortCode = 'YOUR_BUSINESS_SHORTCODE';
    final String password = base64Encode(utf8.encode('$shortCode$passkey$timestamp'));
    return password;
  }

  // Helper function to generate timestamp for API request
  String _generateTimestamp() {
    return DateTime.now().toIso8601String().split('.')[0].replaceAll('-', '').replaceAll(':', '').replaceAll('T', '');
  }
}
