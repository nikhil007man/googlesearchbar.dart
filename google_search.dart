import 'dart:convert';
import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Search Demo Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GoogleSearchPage(),
    );
  }
}

class GoogleSearchPage extends StatefulWidget {
  const GoogleSearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GoogleSearchPageState createState() => _GoogleSearchPageState();
}

class _GoogleSearchPageState extends State<GoogleSearchPage> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  // Replace with your Google API Key and Custom Search Engine ID
  final String _apiKey = 'YOUR_GOOGLE_API_KEY';
  final String _cx = 'YOUR_CUSTOM_SEARCH_ENGINE_ID';
  
  get http => null;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse(
        'https://www.googleapis.com/customsearch/v1?key=$_apiKey&cx=$_cx&q=$query&searchType=image',
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _searchResults = (data['items'] as List)
              .map((item) => {
                    'title': item['title'],
                    'link': item['link'],
                    'image': item['image']['thumbnailLink']
                  })
              .toList();
        });
      } else {
        _showError('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      _showError('oops!!: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _launchURL(String url) async {
    if (url.isNotEmpty) {


      await launch(url);
    } else {
      _showError('Error $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Google',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _performSearch(_searchController.text),
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final result = _searchResults[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: result['image'] != null
                                ? Image.network(
                                    result['image'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.image_not_supported),
                            title: Text(result['title']),
                            onTap: () => _launchURL(result['link']),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
  
  launch(String url) {}
}
