
class SerenoEntity  {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String dni;
  final String? address;
  final String distrito;
  final String? avatar;
  final String birthdate;
  final String role;
  final bool active;

  SerenoEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.dni,
    required this.address,
    required this.distrito,
    required this.avatar,
    required this.birthdate,
    required this.role,
    required this.active,
  });
}