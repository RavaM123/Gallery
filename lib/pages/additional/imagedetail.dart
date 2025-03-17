import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageDetail extends StatefulWidget {
  final String imageUrl;
  final String username;
  final String caption;
  final String uuid;

  const ImageDetail({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.caption,
    required this.uuid,
  });

  @override
  _ImageDetailState createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  String? uploaderUsername;

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    try {
      final response = await Supabase.instance.client
          .from('profile')
          .select('username')
          .eq('id', widget.uuid)
          .maybeSingle();

      setState(() {
        uploaderUsername = response?['username'] ?? 'Unknown';
      });
    } catch (e) {
      debugPrint("Error fetching username: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Diupload oleh:',
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    uploaderUsername ?? 'Uploader',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.caption.isNotEmpty ? widget.caption : 'No Caption',
                      style: const TextStyle(fontSize: 25),
                      maxLines: null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
