import 'dart:io';

import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/features/auth/data/auth_repository.dart';
import 'package:anime_slayer/features/auth/data/requests/login_request_model.dart';
import 'package:anime_slayer/features/auth/presentation/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/remote_auth_data_source.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLogin = useState(true);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final nameController = useTextEditingController();
    final avatar = useState<XFile?>(null);
    final authController = ref.watch(authControllerProvider.notifier);
    void submit() {
      final isValid = formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formKey.currentState!.save();

      if (avatar.value == null && !isLogin.value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('الرجاء اختيار صورة شخصية'),
          ),
        );

        return;
      }

      if (isLogin.value) {
        authController.login(
            data: LoginRequestModel(
          email: emailController.text,
          password: passwordController.text,
        ));
      } else {
        authController.register(
          data: RegisterRequestModel(
            username: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            avatar: avatar.value!,
          ),
        );
      }
    }

    pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        avatar.value = image;
      } else {
        print('no image selected');
      }
    }

    ref.listen(authControllerProvider, ((previous, next) {
      if (next.error == null) {
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تسجيل الدخول بنجاح'),
          ),
        );
      }

      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ ما'),
          ),
        );
      }
    }));

    return Scaffold(
      // back buttonm
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isLogin.value ? 'تسجيل الدخول' : 'انشاء حساب جديد',
                  style: Theme.of(context).textTheme.bodyLarge),
              if (!isLogin.value)
                // a container rounded , if clicked to picka profile picture , its required
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundColor: AppColors.primaryColor,
                    backgroundImage: avatar.value != null
                        ? FileImage(
                            File(avatar.value!.path),
                          )
                        : null,
                    child: avatar.value == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              if (!isLogin.value)
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'الاسم'),
                  validator: (value) =>
                      value!.isEmpty ? 'الرجاء ادخال اسم المستخدم' : null,
                ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'الايميل'),
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء ادخال الايميل' : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'كلمة المرور'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء ادخال كلمة المرور' : null,
              ),
              30.verticalSpace,
              ElevatedButton(
                onPressed: submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  backgroundColor: AppColors.primaryColor,
                ),
                child: Text(
                  isLogin.value ? 'تسجيل الدخول' : 'انشاء حساب جديد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  isLogin.value = !isLogin.value;
                },
                child: Text(isLogin.value
                    ? 'ليس لديك حساب؟ انشاء حساب جديد'
                    : 'لديك حساب بالفعل'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
