import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labapp/Screens/patients/patient_controller.dart';
import 'package:labapp/bottomsheets/common_bottom_sheet.dart';
import 'package:labapp/models/caseModel.dart';
import 'package:labapp/utils/app_color.dart';

class Patientes extends StatelessWidget {
  const Patientes({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientController>(
      builder: (contorller) {
        return Scaffold(
          appBar: AppBar(title: Text("Patients")),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: contorller.patientSearchController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    EasyDebounce.debounce(
                      "patient_seach",
                      Duration(milliseconds: 500),
                      () {
                        contorller.patientPagingController.refresh();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    contorller.patientPagingController.refresh();
                    return Future.value();
                  },
                  child: PagedListView<int, Patient>(
                    pagingController: contorller.patientPagingController,
                    builderDelegate: PagedChildBuilderDelegate<Patient>(
                      itemBuilder: (context, patient, index) => Card(
                        color: AppColor.whitecolor,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Column(
                          children: [
                            _buildHeaderCard(patient),
                            _buildInfoCard(patient),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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

  Widget _buildHeaderCard(patient) {
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
                  "${patient.firstName ?? ''} ${patient.lastName ?? ''}",
                  style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),
                ),
                Text("Gender: ${patient.gender ?? 'N/A'}"),
                Text("Age: ${patient.age ?? 'N/A'}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(patient) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(Icons.badge, "Patient ID", patient.patientId ?? "N/A"),
          _infoRow(
            Icons.phone,
            "Phone",
            (patient.phoneNumbers?.join(", ") ?? "N/A"),
          ),
          _infoRow(Icons.email, "Email", patient.email ?? "N/A"),
          _infoRow(Icons.language, "Address", patient.address.line1 ?? "N/A"),
          // _infoRow(Icons.access_time, "Created At", patient.createdAt ?? "N/A"),
          // _infoRow(Icons.update, "Updated At", patient.updatedAt ?? "N/A"),
        ],
      ),
    );
  }

  Widget _buildAddressCard(patient) {
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

  Widget _infoRow(IconData icon, String label, String value) {
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
}
