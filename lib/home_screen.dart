import 'package:flutter/material.dart';
import 'package:watertracker/water_track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _glassNumTEController = TextEditingController(
    text: "1");

  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWaterTrackerCounter(),
          const SizedBox(height: 24,),
          Expanded(child: _buildWaterTrackListView(),
          )
        ],
      ),
    );
  }

  Widget _buildWaterTrackListView() {
    return ListView.separated(
      itemCount: waterTrackList.length,
            itemBuilder: (context, index){
              return _buildWaterTrackListTile(index);
            },
            separatorBuilder: (context, index){
              return const Divider();
            },
            );
  }
  ListTile _buildWaterTrackListTile(int index) {
    WaterTrack waterTrack = waterTrackList[index];
    return ListTile(
              title: Text('${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}'),
              subtitle: Text('${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}'),
              leading: CircleAvatar(child: Text('${waterTrack.noOfGlasses}'),),
              trailing: IconButton(
                  onPressed: () => _onTapDeleteButton(index),
                  icon: Icon(Icons.delete),),
            );
  }
  Widget _buildWaterTrackerCounter() {
    return Column(
          children: [
            Text(getTotalGlassCount().toString(),
              style:const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),),
            const SizedBox(height: 16,),
            const Text('Glass/s', style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                    height: 65,
                    child: TextField(
                      controller: _glassNumTEController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    )
                ),
                TextButton(
                  onPressed: _onTapAddNewWaterTrack,
                  child: const Text('Add',style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),),
                ),
              ],
            ),
          ],
        );
  }

  int getTotalGlassCount(){
    int countr = 0;
    for (WaterTrack t in waterTrackList){
      countr += t.noOfGlasses;
    }
    return countr;
  }
  void _onTapAddNewWaterTrack(){
    if (_glassNumTEController.text.isEmpty){
      _glassNumTEController.text = '1';
    }
    final int noOfGlasses = int.tryParse(_glassNumTEController.text) ?? 1;
    WaterTrack waterTrack = WaterTrack(
        noOfGlasses: noOfGlasses,
        dateTime: DateTime.now(),
    );
    waterTrackList.add(waterTrack);
    setState(() {});
  }
  void _onTapDeleteButton(int index){
    waterTrackList.removeAt(index);
    setState(() {});
  }
  @override
  void dispose() {
    _glassNumTEController.dispose();
    super.dispose();
  }
}
