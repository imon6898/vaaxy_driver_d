import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class FileSelector extends StatefulWidget {
  final ValueChanged<List<File>> onFilesSelected;

  FileSelector({required this.onFilesSelected});

  @override
  _FileSelectorState createState() => _FileSelectorState();
}

class _FileSelectorState extends State<FileSelector> {
  List<File> _selectedFiles = [];
  double _containerHeight = 60;

  final ImagePicker _picker = ImagePicker();

  void _addFile() async {
    List<File> files = await _pickImages();
    if (files.isNotEmpty) {
      setState(() {
        _selectedFiles.addAll(files);
        _updateContainerHeight();
        widget.onFilesSelected(_selectedFiles);
      });
    }
  }

  Future<List<File>> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      return pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    } else {
      return [];
    }
  }

  void _updateContainerHeight() {
    setState(() {
      _containerHeight = _selectedFiles.isNotEmpty ? 200 : 60;
    });
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
      _updateContainerHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              if (_selectedFiles.length >= 8) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Maximum 8 images can be added.'),
                  ),
                );
              } else {
                _addFile();
              }
            },
            child: Text('Attach Image'),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedFiles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          _selectedFiles[index],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(path.basename(_selectedFiles[index].path)),
                      subtitle: Text('Vehicle Image ${index + 1}'),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => _removeFile(index),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
