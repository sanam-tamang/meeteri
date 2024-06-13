import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meeteri/common/utils/custom_toast.dart';
import 'package:toastification/toastification.dart';
import '../repositories/user_repository.dart';

//TODO: make later ask for complete your profile
class CounselorPage extends StatefulWidget {
  const CounselorPage({super.key});

  @override
  State<CounselorPage> createState() => _CounselorPageState();
}

class _CounselorPageState extends State<CounselorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _specializationController,
                decoration: const InputDecoration(
                  labelText: 'Specialization',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your specialization';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, save the data
                    final phoneNumber = _phoneNumberController.text;
                    final address = _addressController.text;
                    final specialization = _specializationController.text;
                    // final hospital = _hospitalController.text.isEmpty
                    //     ? null
                    //     : _hospitalController.text;

                    UserRepository()
                        .addCounselorInfo(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            phoneNumber: phoneNumber,
                            address: address,
                            specialization: specialization,
                            hospital: "")
                        .then((value) {
                      customToast(context, "Counselor info added");
                     
                    }).catchError((_) {
                      customToast(context, "Error occured",
                          type: ToastificationType.error);
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _addressController.dispose();
    _specializationController.dispose();
    
    super.dispose();
  }
}
