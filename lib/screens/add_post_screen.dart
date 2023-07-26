import 'dart:typed_data';

import 'package:clone_insta/providers/user_provider.dart';
import 'package:clone_insta/resources/firestore_methods.dart';
import 'package:clone_insta/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/users.dart';
import '../utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool _isLoading=false;
  final TextEditingController _descriptionController=TextEditingController();

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      _isLoading=true;
    });
    try{
      String res=await FirestoreMethods().uploadPost(_descriptionController.text, _file!, uid, username, profImage);
      if(res=='Success'){
        setState(() {
          _isLoading=false;
        });
        showSnackBar('Posted', context);
      }else{
        setState(() {
          _isLoading=false;
        });
        showSnackBar(res, context);
      }
    }catch(err){
      showSnackBar(err.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
        title: Center(child: const Text('Create Post')),
        children: [
          Center(
            child: SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: const Text('Take a photo',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file= await pickImage(ImageSource.camera);
                setState(() {
                  _file=file;
                });
              },
            ),
          ),
          Center(
            child: SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: const Text('Choose from gallery',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file= await pickImage(ImageSource.gallery);
                setState(() {
                  _file=file;
                });
              },
            ),
          ),
          Center(
            child: SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: const Text('Cancel',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),

        ],
      );
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final User user= Provider.of<UserProvider>(context).getUser;
    return _file==null?Center(
      child: IconButton(
        icon: const Icon(Icons.upload, color: primaryColor,),
        onPressed: () => _selectImage(context),
      ),
    ): Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: primaryColor,
          onPressed: () {},
        ),
        title: const Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(onPressed:()=>postImage(user.uid,user.username,user.photoUrl), child: const Text('Post', style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16
          )))
        ],
      ),
      body: Column(
        children: [
          _isLoading? LinearProgressIndicator(): Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.45,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Write a caption...',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                )
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter
                      )
                    ),
                  ),
                )
              ),
              const Divider(),
            ],
          ),
        ],
      )
    );
  }
}
