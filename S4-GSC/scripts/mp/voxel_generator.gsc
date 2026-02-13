/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\voxel_generator.gsc
*************************************************/

generatevoxelstructure(var_0) {
  wait 40.0;
  var_1 = tablelookupgetnumrows("mp/monumentVoxelData.csv");

  for(var_2 = 1; var_2 < var_1; var_2++) {
    var_3 = readvoxelpositiondata("mp/monumentVoxelData.csv", var_2);
    var_3 = rotatevector(var_3, (0, 0, 90));
    var_4 = _func_03C5("scriptable_test_notify_damage_noent_yescallback", var_0 + var_3);
    var_4.health = 100;
    var_4 _id_07A1::_id_CEC7(::destroyvoxel);
    waitframe();
  }
}

readvoxelpositiondata(var_0, var_1) {
  var_2 = int(tablelookupbyrow(var_0, var_1, 0));
  var_3 = int(tablelookupbyrow(var_0, var_1, 1));
  var_4 = int(tablelookupbyrow(var_0, var_1, 2));
  return (var_2, var_3, var_4);
}

destroyvoxel(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_0.health = var_0.health - var_1;

  if(var_0.health <= 0) {
    var_0 setscriptablepartstate("panel", "script_death");
  }
}