import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../style/handle.dart';

class ChangeUser extends StatefulWidget {
  const ChangeUser({super.key});

  @override
  State<ChangeUser> createState() => _ChangeUserState();
}

class _ChangeUserState extends State<ChangeUser> {
  final TextEditingController _usernameController = TextEditingController();

  Future<void> _updateDisplayName(String username) async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user == null || user.id.isEmpty) {
        throw Exception('User belum terautentikasi atau ID tidak valid');
      }

      debugPrint("User ID: ${user.id}");
      debugPrint("Username Baru: $username");

      // Perbarui username
      await supabase.from('profile').upsert(
        {
          'id': user.id,
          'username': username,
        },
        onConflict: 'id',
      );

      // Ambil data terbaru setelah perubahan
      final updatedProfile = await supabase
          .from('profile')
          .select('username')
          .eq('id', user.id)
          .single();

      if (updatedProfile == null) {
        throw Exception('Gagal mengambil data terbaru dari Supabase');
      }

      debugPrint("Username setelah update: ${updatedProfile['username']}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username berhasil diperbarui')),
      );
      Navigator.pop(context);
    } catch (e) {
      debugPrint("Gagal memperbarui nama pengguna: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengupdate data: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Username',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama pengguna',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextfield(
              textCapitalization: TextCapitalization.sentences,
              controller: _usernameController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress,
              hintText: 'username',
            ),
            const SizedBox(height: 8),
            const Text(
              'Username dilarang mengandung SARA, ujaran kebencian, kata-kata tidak pantas, dan sebagainya',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text.trim();
                  if (username.isNotEmpty) {
                    _updateDisplayName(username);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Nama pengguna tidak boleh kosong')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child:
                    const Text("Simpan", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
