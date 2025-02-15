interface class LoginEntity {}

class LoginRequestEntity extends LoginEntity {
  final String email;
  final String password;

  LoginRequestEntity({
    required this.email,
    required this.password,
  });
}

class LoginResponseEntity extends LoginEntity {
  bool? status;
  String? message;
  String? token;
  int? id;
  DataEntity? data;

  LoginResponseEntity({
    this.status,
    this.message,
    this.token,
    this.id,
    this.data,
  });
}

class DataEntity {
  int? id;
  String? name;
  dynamic roasterGroupId;
  String? userType;
  dynamic depotId;
  String? cardNo;
  String? email;
  String? password;
  String? mobile;
  String? type;
  String? joiningDate;
  String? inactiveDate;
  String? bankAccount;
  String? bloodGroup;
  String? dateOfBirth;
  String? presentAddress;
  dynamic permanentAddress;
  String? emergencyContact;
  dynamic reference;
  int? gradeId;
  int? designationId;
  int? departmentId;
  dynamic requisitionId;
  dynamic candidateId;
  int? companyLocationId;
  dynamic workplaceId;
  dynamic workplaceType;
  dynamic notes;
  int? departmentHead;
  int? approvedBy;
  String? status;
  dynamic createdAt;
  String? updatedAt;
  dynamic deletedAt;

  DataEntity({
    this.id,
    this.name,
    this.roasterGroupId,
    this.userType,
    this.depotId,
    this.cardNo,
    this.email,
    this.password,
    this.mobile,
    this.type,
    this.joiningDate,
    this.inactiveDate,
    this.bankAccount,
    this.bloodGroup,
    this.dateOfBirth,
    this.presentAddress,
    this.permanentAddress,
    this.emergencyContact,
    this.reference,
    this.gradeId,
    this.designationId,
    this.departmentId,
    this.requisitionId,
    this.candidateId,
    this.companyLocationId,
    this.workplaceId,
    this.workplaceType,
    this.notes,
    this.departmentHead,
    this.approvedBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "roaster_group_id": roasterGroupId,
    "user_type": userType,
    "depot_id": depotId,
    "card_no": cardNo,
    "email": email,
    "password": password,
    "mobile": mobile,
    "type": type,
    "joining_date": joiningDate,
    "inactive_date": inactiveDate,
    "bank_account": bankAccount,
    "blood_group": bloodGroup,
    "date_of_birth": dateOfBirth,
    "present_address": presentAddress,
    "permanent_address": permanentAddress,
    "emergency_contact": emergencyContact,
    "reference": reference,
    "grade_id": gradeId,
    "designation_id": designationId,
    "department_id": departmentId,
    "requisition_id": requisitionId,
    "candidate_id": candidateId,
    "company_location_id": companyLocationId,
    "workplace_id": workplaceId,
    "workplace_type": workplaceType,
    "notes": notes,
    "department_head": departmentHead,
    "approved_by": approvedBy,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
