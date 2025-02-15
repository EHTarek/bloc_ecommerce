
import 'package:bloc_ecommerce/features/authentication/domain/entity/login_entity.dart';

extension LoginRequestModel on LoginRequestEntity {
  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}

class LoginResponseModel extends LoginResponseEntity {
  LoginResponseModel({
    super.status,
    super.message,
    super.token,
    super.id,
    super.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    message: json["message"],
    token: json["token"],
    id: json["id"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
    "id": id,
    "data": data?.toJson(),
  };
}

extension on DataEntity {
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

class Data extends DataEntity {

  Data({
    super.id,
    super.name,
    super.roasterGroupId,
    super.userType,
    super.depotId,
    super.cardNo,
    super.email,
    super.password,
    super.mobile,
    super.type,
    super.joiningDate,
    super.inactiveDate,
    super.bankAccount,
    super.bloodGroup,
    super.dateOfBirth,
    super.presentAddress,
    super.permanentAddress,
    super.emergencyContact,
    super.reference,
    super.gradeId,
    super.designationId,
    super.departmentId,
    super.requisitionId,
    super.candidateId,
    super.companyLocationId,
    super.workplaceId,
    super.workplaceType,
    super.notes,
    super.departmentHead,
    super.approvedBy,
    super.status,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    roasterGroupId: json["roaster_group_id"],
    userType: json["user_type"],
    depotId: json["depot_id"],
    cardNo: json["card_no"],
    email: json["email"],
    password: json["password"],
    mobile: json["mobile"],
    type: json["type"],
    joiningDate: json["joining_date"],
    inactiveDate: json["inactive_date"],
    bankAccount: json["bank_account"],
    bloodGroup: json["blood_group"],
    dateOfBirth: json["date_of_birth"],
    presentAddress: json["present_address"],
    permanentAddress: json["permanent_address"],
    emergencyContact: json["emergency_contact"],
    reference: json["reference"],
    gradeId: json["grade_id"],
    designationId: json["designation_id"],
    departmentId: json["department_id"],
    requisitionId: json["requisition_id"],
    candidateId: json["candidate_id"],
    companyLocationId: json["company_location_id"],
    workplaceId: json["workplace_id"],
    workplaceType: json["workplace_type"],
    notes: json["notes"],
    departmentHead: json["department_head"],
    approvedBy: json["approved_by"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );
}
