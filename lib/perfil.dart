import 'package:flutter/material.dart';

enum ProfileViewState {
  view,
  edit,
  chooseAvatar,
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileViewState _state = ProfileViewState.view;
  int? _selectedAvatarIndex;

  final TextEditingController _nameController =
      TextEditingController(text: "Guilherme Nunes Rozendo");
  final TextEditingController _emailController =
      TextEditingController(text: "rm90185@estudante.com.br");
  final TextEditingController _phoneController =
      TextEditingController(text: "11 99999-9999");

  void switchState(ProfileViewState newState) {
    setState(() {
      _state = newState;
    });
  }

  void saveChanges() {
    switchState(ProfileViewState.view);
  }

  void selectAvatar(int index) {
    setState(() {
      _selectedAvatarIndex = index;
      _state = ProfileViewState.edit;
    });
  }

  Widget buildAvatar() {
    if (_selectedAvatarIndex != null) {
      return CircleAvatar(
        radius: 50,
        backgroundImage:
            AssetImage('assets/avatar_${_selectedAvatarIndex!}.png'),
      );
    }
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey[300],
      child: Icon(Icons.person_outline, size: 80),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.topRight,
              children: [
                buildAvatar(),
                IconButton(
                  icon: Icon(Icons.edit, size: 20),
                  onPressed: () => switchState(ProfileViewState.chooseAvatar),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_state != ProfileViewState.chooseAvatar) _buildForm(),
            if (_state == ProfileViewState.chooseAvatar) _buildAvatarSelection(),
            _buildBottomButtons(),
            SizedBox(height: 20),
            _buildSocialLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Color(0xFF0C0C3E),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text('Voltar', style: TextStyle(color: Colors.white)),
          ),
          Text('Perfil',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildForm() {
    bool isEditing = _state == ProfileViewState.edit;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          _buildTextField("Nome completo", _nameController, isEditing),
          _buildTextField("Email", _emailController, isEditing),
          _buildTextField("Telefone", _phoneController, isEditing),
          _buildPasswordField(),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool enabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.edit, size: 18),
            enabledBorder: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Senha",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        TextField(
          obscureText: true,
          enabled: false,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.visibility_off),
            enabledBorder: UnderlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    if (_state == ProfileViewState.view) {
      return ElevatedButton(
        onPressed: () => switchState(ProfileViewState.edit),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[700],
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        ),
        child: Text("Editar", style: TextStyle(color: Colors.black)),
      );
    } else if (_state == ProfileViewState.edit) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button("Cancelar", () => switchState(ProfileViewState.view),
              color: Colors.grey),
          SizedBox(width: 20),
          _button("Salvar", saveChanges, color: Colors.yellow[700]!),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _button(String text, VoidCallback onPressed, {required Color color}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      child: Text(text, style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildAvatarSelection() {
    final avatars = List.generate(12, (i) => i);
    return Expanded(
      child: Column(
        children: [
          Text("Escolha seu avatar",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: avatars
                .map((index) => GestureDetector(
                      onTap: () => selectAvatar(index),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/avatar_$index.png'),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button("Cancelar", () => switchState(ProfileViewState.view),
                  color: Colors.grey),
              SizedBox(width: 20),
              _button("Salvar", () => switchState(ProfileViewState.edit),
                  color: Colors.yellow[700]!),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Divider(),
        Text("Logar com"),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue.withOpacity(0.1),
              child: Icon(Icons.facebook, color: Colors.blue),
            ),
            SizedBox(width: 20),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red.withOpacity(0.1),
              child: Icon(Icons.g_mobiledata, color: Colors.red),
            ),
          ],
        )
      ],
    );
  }
}