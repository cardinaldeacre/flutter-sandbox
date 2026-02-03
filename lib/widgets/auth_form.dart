import 'package:flutter/material.dart';
import 'package:violet/screen/main_wrapper.dart';
import '../services/auth_service.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _nimController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isRememberMe = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _doLogin() async {
    setState(() => _isLoading = true);

    final result = await AuthService.login(
      _nimController.text,
      _passwordController.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result['statusCode'] == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainWrapper()),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login berhasil")));
    } else {
      final errorMessage = result['error'] ?? 'Terjadi kesalahan tak terduga';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }

    final message = (result['data'] != null)
        ? (result['data']['message'] ?? 'Unknown response')
        : 'Gagal terhubung ke server';

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nimController,
              decoration: const InputDecoration(labelText: 'NIM'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Isi NIM Anda';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Isi password Anda';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isRememberMe,
                  onChanged: (value) {
                    setState(() {
                      _isRememberMe = value ?? false;
                    });
                  },
                ),
                const Text('Ingat Saya'),
              ],
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _doLogin,
                    child: const Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
