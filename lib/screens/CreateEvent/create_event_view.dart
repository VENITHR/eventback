import 'package:bookevent/core/validation.dart';
import 'package:bookevent/screens/widget/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_event_provider.dart';

class CreateEventView extends StatelessWidget {
  const CreateEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreateEventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: provider.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    CustomTextField(
                      label: "Title",
                      controller: provider.title,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.title,
                      validator: Validation.validateName,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "Description",
                      controller: provider.description,
                      keyboardType: TextInputType.multiline,
                      prefixIcon: Icons.description,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "Capacity",
                      controller: provider.capacity,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.people,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "Start Time",
                      controller: provider.startTime,
                      readOnly: true,
                      prefixIcon: Icons.calendar_today,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            DateTime fullDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            provider.startTime.text =
                                fullDateTime.toUtc().toIso8601String();
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "End Time",
                      controller: provider.endTime,
                      readOnly: true,
                      prefixIcon: Icons.calendar_today,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            DateTime fullDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            provider.endTime.text =
                                fullDateTime.toUtc().toIso8601String();
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "Location",
                      controller: provider.location,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (provider.formKey.currentState!.validate()) {
                            provider.createEvent();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Event Created Successfully")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Text("Create Event"),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
