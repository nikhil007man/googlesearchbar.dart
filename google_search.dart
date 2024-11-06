import 'package:flutter/material.dart';

class GoogleScreen extends StatelessWidget {
  const GoogleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8ECEA), 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50), 
              const Center(
                child: Text(
                  'Google',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(137, 223, 176, 176),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6DAD5), 
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(Icons.search, color: Colors.black54),
                    Expanded(
                      child: Text(
                        'Search or type URL',
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                    Icon(Icons.mic, color: Colors.black54),
                    SizedBox(width: 16),
                    Icon(Icons.camera_alt, color: Colors.black54),
                    SizedBox(width: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),

          const Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
     Text(
                'Discover – off',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
    Icon(Icons.more_vert),
  ],
)
    
            
            ],
          ),
        ),
      ),
    );
  }
}