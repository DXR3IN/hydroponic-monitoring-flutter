class DeviceEntity {
  final String id;
  final String deviceName;
  final String ownerID;
  final String status;
  final DateTime createdAt;
  // final DateTime updatedAt;

  const DeviceEntity({
    required this.id,
    required this.deviceName,
    required this.ownerID,
    required this.status,
    required this.createdAt,
    // required this.updatedAt
  });
}
