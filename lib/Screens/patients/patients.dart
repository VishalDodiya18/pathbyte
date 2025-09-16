import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:Pathbyte/Constants/text_constant.dart';
import 'package:Pathbyte/Constants/textfield_constant.dart';
import 'package:Pathbyte/Constants/widget_constant.dart';
import 'package:Pathbyte/Screens/patients/edit_patient.dart';
import 'package:Pathbyte/Screens/patients/patient_controller.dart';
import 'package:Pathbyte/Screens/patients/patient_details.dart';
import 'package:Pathbyte/Screens/patients/patient_details_controller.dart';
import 'package:Pathbyte/models/caseModel.dart';
import 'package:Pathbyte/utils/app_color.dart';
import 'package:Pathbyte/utils/app_config.dart';

class Patientes extends StatelessWidget {
  const Patientes({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientController>(
      builder: (contorller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox(14),
                TextConstant(
                  title:
                      'Patients${contorller.responseModel == null ? "" : " ( ${contorller.responseModel?.data?.pagination?.total} )"}',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                heightBox(10),
                TextFieldConstant(
                  controller: contorller.patientSearchController,
                  hintText: 'Search By Patient ID/Name/ No',
                  suffixIcon:
                      contorller.patientSearchController.text.trim().isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            contorller.patientSearchController.clear();
                            contorller.update();
                            FocusScope.of(context).unfocus();
                            Future.delayed(Duration(milliseconds: 100), () {
                              contorller.patientPagingController.refresh();
                            });
                          },
                          child: Icon(Icons.clear_rounded, size: 25.h),
                        )
                      : null,
                  onChanged: (p0) {
                    contorller.update();

                    EasyDebounce.debounce(
                      'case-search-debouncer',
                      Duration(milliseconds: 500),
                      () {
                        FocusScope.of(context).unfocus();
                        Future.delayed(Duration(milliseconds: 100), () {
                          contorller.patientPagingController.refresh();
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      contorller.patientPagingController.refresh();
                      return Future.value();
                    },
                    child: PagedListView<int, Patient>(
                      pagingController: contorller.patientPagingController,
                      builderDelegate: PagedChildBuilderDelegate<Patient>(
                        noItemsFoundIndicatorBuilder: (context) =>
                            Center(child: Image.asset(AppImage.nodatafound)),
                        itemBuilder: (context, patient, index) =>
                            GestureDetector(
                              onTap: () {
                                Get.lazyPut(
                                  () => PatientDetailsController(
                                    patient: patient,
                                  ),
                                );
                                Get.to(PatientDetails());
                              },
                              child: Card(
                                color: AppColor.whitecolor,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                                child: Column(
                                  children: [
                                    buildHeaderCard(context, patient),
                                    buildInfoCard(patient),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //  PaginatedSelectionSheet<Patient>(
          //   title: "Patient",

          //   keyboardType: TextInputType.number,
          //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          //   controller: contorller.patientPagingController,
          //   itemId: (item) => item.sId ?? "",
          //   itemLabel: (item) =>
          //       "${item.phoneNumbers?.first}\n${item.firstName} ${item.lastName} (${item.patientId})",
          //   selectedItem: null,
          //   searchController: contorller.patientSearchController,

          //   onSelect: (patient) {},
          // ),
        );
      },
    );
  }
}

Widget buildHeaderCard(context, patient, {isedit = false}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundColor: AppColor.primary,
          child: Text(
            (patient.firstName?.substring(0, 1) ?? "").toUpperCase(),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${patient.title ?? ''} ${patient.firstName ?? ''} ${patient.lastName ?? ''}",
                style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),
              ),
              Text("Gender: ${patient.gender ?? 'N/A'}"),
              Text("Age: ${patient.age ?? 'N/A'}"),
            ],
          ),
        ),
        if (isedit)
          IconButton(
            onPressed: () {
              showPatientDialog(context, patient);
            },
            icon: Icon(Icons.edit, color: AppColor.primary),
          ),
      ],
    ),
  );
}

Widget buildInfoCard(patient) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoRow(Icons.badge, "Patient ID", patient.patientId ?? "N/A"),
        infoRow(
          Icons.phone,
          "Phone",
          (patient.phoneNumbers?.join(", ") ?? "N/A"),
        ),
        infoRow(Icons.email, "Email", patient.email ?? "N/A"),
        infoRow(Icons.language, "Address", patient.address.line1 ?? "N/A"),
        // infoRow(Icons.access_time, "Created At", patient.createdAt ?? "N/A"),
        // infoRow(Icons.update, "Updated At", patient.updatedAt ?? "N/A"),
      ],
    ),
  );
}

Widget buildAddressCard(patient) {
  final address = patient.address!;
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Address",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.primary,
            ),
          ),
          const Divider(),
          Text("Street: ${address.street ?? 'N/A'}"),
          Text("City: ${address.city ?? 'N/A'}"),
          Text("State: ${address.state ?? 'N/A'}"),
          Text("Zip Code: ${address.zipCode ?? 'N/A'}"),
          Text("Country: ${address.country ?? 'N/A'}"),
        ],
      ),
    ),
  );
}

Widget infoRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, color: AppColor.primary, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Text("$label: $value", style: const TextStyle(fontSize: 15)),
        ),
      ],
    ),
  );
}
