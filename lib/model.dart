class Company {
  String name;
  String agentRate;
  String city;

  Company({required this.name, required this.agentRate, required this.city});

  factory Company.fromJson(Map<String, dynamic> json) {
    final agentDetails = json['sectionData']['Agent Details'];
    return Company(
      name: agentDetails['name'],
      agentRate: agentDetails['agentrate'],
      city: agentDetails['city'],
    );
  }
}
