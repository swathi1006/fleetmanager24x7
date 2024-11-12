import 'dart:convert';

import 'package:fleet_manager_driver_app/utils/color.dart';
import 'package:fleet_manager_driver_app/widget/toaster_message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/scratch.dart';
class BodyConditionScreen extends StatefulWidget {
  const BodyConditionScreen(this.scratchData,this._isStored,{Key? key}) : super(key: key);
  final Scratch scratchData;
  final bool _isStored;

  @override
  State<BodyConditionScreen> createState() => _BodyConditionScreenState();
}

class _BodyConditionScreenState extends State<BodyConditionScreen> {

  late final Scratch scratchData;

  @override
  void initState() {
    super.initState();
    scratchData = widget.scratchData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body:ListView(
        scrollDirection: Axis.vertical,
        children: [
          //front View
          scratchData.scratchFV.startsWith('assets')?
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child:const Center(child:Text("No scratches on front",style: TextStyle(color: primary),)),
          ):
          GestureDetector(
            onTap: scratchData.scratchOrgLsv?.length !=0 ? (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildIssueAlert('FRONT VIEW',scratchData.scratchOrgLsv);
                },
              );
            }:(){
              createToastTop("No scratch images found");
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Container(
                height: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  image: DecorationImage(
                    image: MemoryImage(base64Decode((scratchData.scratchFV))),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child:Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: greenlight.withOpacity(.2),width: 2),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  const EdgeInsets.only(top:10.0),
                              child: Text('FRONT VIEW',style: GoogleFonts.lato(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800),),
                            ),
                          ],
                        ),
                      ),
                    ],
                ),
              ),
            ),
          ),

          //backview
          scratchData.scratchBV.startsWith('assets')?
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child:const Center(child:Text("No scratches on back",style: TextStyle(color: primary))),
          ):
          GestureDetector(
            onTap: scratchData.scratchOrgBv?.length !=0 ? (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildIssueAlert('BACK VIEW',scratchData.scratchOrgBv);
                },
              );
            }:(){
              createToastTop("No scratch images found");
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Container(
                height: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  image: DecorationImage(
                    image: MemoryImage(base64Decode((scratchData.scratchBV))),
//                    image: AssetImage('assets/image/svu_back.jpg'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child:Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: greenlight.withOpacity(.2),width: 2),

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: Text('BACK VIEW',style: GoogleFonts.lato(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //rightsideview
          scratchData.scratchRSV.startsWith('assets') ?
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child:const Center(child:Text("No scratches on right side",style: TextStyle(color: primary))),
          ):
          GestureDetector(
            onTap: scratchData.scratchOrgRsv?.length !=0 ? (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildIssueAlert('RIGHT SIDE VIEW',scratchData.scratchOrgRsv);
                },
              );
            }:(){
              createToastTop("No scratch images found");
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Container(
                height: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  image: DecorationImage(
                    image:  MemoryImage(base64Decode((scratchData.scratchRSV))),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child:Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: greenlight.withOpacity(.2),width: 2),

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: Text('RIGHT SIDE VIEW',style: GoogleFonts.lato(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //leftsideview
          scratchData.scratchLSV.startsWith('assets') ?
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child:const Center(child:Text("No scratches on left side",style: TextStyle(color: primary))),
          ):
          GestureDetector(
            onTap: scratchData.scratchOrgLsv?.length!=0 ? (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildIssueAlert('LEFT SIDE VIEW',scratchData.scratchOrgLsv);
                },
              );
            }:(){
              createToastTop("No scratch images found");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Container(
                height: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  image: DecorationImage(
                    image:  MemoryImage(base64Decode((scratchData.scratchLSV))),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child:Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: greenlight.withOpacity(.2),width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: Text('LEFT SIDE VIEW',style: GoogleFonts.lato(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //topview
          scratchData.scratchTV.startsWith('assets')?
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child:const Center(child:Text("No scratches on top",style: TextStyle(color: primary))),
          ):
          GestureDetector(
            onTap: scratchData.scratchOrgTv?.length!=0 ?(){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildIssueAlert('TOP VIEW',scratchData.scratchOrgTv);
                },
              );
            }:(){
              createToastTop("No scratch images found");
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Container(
                height: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  image: DecorationImage(
                    image:  MemoryImage(base64Decode((scratchData.scratchTV))),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child:Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: greenlight.withOpacity(.2),width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: Text('TOP VIEW',style: GoogleFonts.lato(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  AlertDialog buildIssueAlert(title,imgPathList) {
    return AlertDialog(
      title: Center(child: Text(title,style: GoogleFonts.lato(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800))),
      backgroundColor: secondary,
      content: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.width,
                width: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: imgPathList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Image.memory(base64Decode(imgPathList[index]),fit: BoxFit.fill,),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(8),
                  backgroundColor: WidgetStateProperty.all(greenlight),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                ),
                child: Text('CLOSE',style: GoogleFonts.lato(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),),
              ),
            ],
          ),
      ),
    );
  }
}
