import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/core/domain/api_service.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/signup_controller.dart';


/// CustomImagePicker with doted border box
class CustomImagePicker extends StatelessWidget {
  final String heading;
  final BorderRadius borderRadius;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final void Function(File?) onImagePicked;
  final File? selectedImage; // New parameter for custom selected image
  final String imageLink;

  CustomImagePicker({
    Key? key,
    required this.heading,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.validator,
    this.imageLink = '',
    this.suffixIcon,
    required this.onImagePicked,
    this.selectedImage, // Initialize the selected image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  children: [
                    TextSpan(text:  heading,style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.5,
                    ),),
                    const TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              DottedBorder(
                dashPattern: [8, 4],
                strokeWidth: 2,
                color: const Color(0xffffffff),
                child: InkWell(
                  onTap: () {
                    _showImageSourceActionSheet(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    child: Center(
                      child: imageLink.isNotEmpty && selectedImage == null
                          ? CustomImageLoader(imageUrl: imageLink)
                          : selectedImage == null
                          ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Color(0xff1D71B8),
                            size: 24,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Upload Image",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 20 / 14,
                              color: Color(0xFF1D71B8),
                            ),
                          ),
                        ],
                      )
                          : Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (selectedImage != null && _getImageSizeInMB(selectedImage!) > 5)
                const Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Max size 5MB",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(context, ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(context, ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  double _getImageSizeInMB(File imageFile) {
    int bytes = imageFile.lengthSync();
    double megabytes = bytes / (1024 * 1024);
    return megabytes;
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        var file = File(image.path);
        /* final fileSize = await file.length();
        if (fileSize > 10 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image size should be less than 5MB.'),
              backgroundColor: Colors.red,
            ),
          );
          onImagePicked(null);
        } */
        //check image size
        final profileImageSize = file.lengthSync();
        if (profileImageSize > 5000000) {
          file = File('');
          showErrorSnackbar(message: 'Image size should be less than 5MB');
          return;
        }
        onImagePicked(file);
      } else {
        onImagePicked(null);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}

class CustomImageLoader extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;
  final Widget? placeholder;

  const CustomImageLoader({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return imageUrl.contains(".svg")
        ? FutureBuilder<bool>(
      future: _checkSvg(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: placeholder ?? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || !snapshot.hasData || !snapshot.data!) {
          return errorWidget ?? const Center(child: Icon(Icons.error));
        } else {
          return SvgPicture.network(
            imageUrl,
            placeholderBuilder: (BuildContext context) => Center(
              child: placeholder ?? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
            ),
            fit: fit,
            width: width,
            height: height,
          );
        }
      },
    )
        : CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Center(
        child: placeholder ?? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => errorWidget ?? const Center(child: Icon(Icons.error)),
    );
  }

  Future<bool> _checkSvg(String url) async {
    Dio dio = Dio();
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}





class CustomImagePickers extends StatefulWidget {
  final File? imageFile;
  final Function(File?)? onImageSelected;

  const CustomImagePickers({
    Key? key,
    required this.imageFile,
    this.onImageSelected,
  }) : super(key: key);

  @override
  _CustomImagePickersState createState() => _CustomImagePickersState();
}

class _CustomImagePickersState extends State<CustomImagePickers> {
  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null && widget.onImageSelected != null) {
        widget.onImageSelected!(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });

    Navigator.of(context).pop();
  }

  Future<Uint8List?> _readImageBytes(File? file) async {
    if (file == null) return null;
    return await file.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: widget.imageFile != null
                    ? FutureBuilder<Uint8List?>(
                  future: _readImageBytes(widget.imageFile),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      );
                    } else {
                      return SvgPicture.asset(
                        'assets/svg/avatar-svgrepo-com.svg',
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      );
                    }
                  },
                )
                    : SvgPicture.asset(
                  'assets/svg/avatar-svgrepo-com.svg',
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -10,
              child: Visibility(
                visible: widget.onImageSelected != null,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text('Take a photo'),
                              onTap: () {
                                _getImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('Choose from gallery'),
                              onTap: () {
                                _getImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.camera),
                                title: Text('Take a photo'),
                                onTap: () {
                                  _getImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('Choose from gallery'),
                                onTap: () {
                                  _getImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}



