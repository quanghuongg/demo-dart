import 'dart:convert';
import 'package:http/http.dart' as http;

class ListNestResponse {
  String errorCode;
  Data data;

  ListNestResponse({required this.errorCode, required this.data});

  factory ListNestResponse.fromJson(Map<String, dynamic> json) {
    return ListNestResponse(
      errorCode: json['error_code'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  List<Nest> nest;

  Data({required this.nest});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['nest'] as List;
    List<Nest> nestList = list.map((i) => Nest.fromJson(i)).toList();
    return Data(nest: nestList);
  }
}

class Nest {
  int id;
  int status;
  int?  typeEgg;

  Nest({required this.id, required this.status, required this.typeEgg});

  factory Nest.fromJson(Map<String, dynamic> json) {
    return Nest(
      id: json['id'],
      status: json['status'],
      typeEgg: json['type_egg'],
    );
  }
}


Future<ListNestResponse> fetchEggs(String accessToken) async {
  final url = Uri.parse('https://api.quackquack.games/nest/list-reload');
  final headers = {
    'accept': '*/*',
    'accept-language': 'vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7,fr-FR;q=0.6,fr;q=0.5',
    'authorization': 'Bearer $accessToken',
    'if-none-match': 'W/"122c-eKQklfAkvog9YZwc9NUM1+FAVrg"',
    'origin': 'https://quackquack-prj.s3.ap-southeast-1.amazonaws.com',
    'priority': 'u=1, i',
    'referer': 'https://quackquack-prj.s3.ap-southeast-1.amazonaws.com/',
    'sec-ch-ua': '"Google Chrome";v="125", "Chromium";v="125", "Not.A/Brand";v="24"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"macOS"',
    'sec-fetch-dest': 'empty',
    'sec-fetch-mode': 'cors',
    'sec-fetch-site': 'cross-site',
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
  };

  final response = await http.get(url, headers: headers);
  if (response.statusCode == 200) {
    return ListNestResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load eggs');
  }
}



