/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\trial_pitcher.gsc
***********************************************/

init() {
  foreach(var_1 in level.players)
  var_1 thread firemanager();
}

firemanager() {
  self.offhands = spawnStruct();
  self.offhands.lastusedoffhandweapon = undefined;
  self.offhands.lastusedoffhandtime = 0;

  for(;;) {
    self waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_0, var_1);

    if(var_1.basename == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0")
      thread watchforimpact(var_0);
  }
}

watchforimpact(var_0) {
  var_0.owner = self;
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_1 = getmissileowner(var_0);
  var_0 waittill("_encstr_860808CB78E2984063BA", var_2, var_3, var_4, var_5);
  thread molotovexplode(var_2, var_3, var_4, var_5, var_1);
}

molotovexplode(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_5 setModel("_encstr_862716E0AF0BD047DA28B19B4D8E2A48E1CD53AF44778D43");
  var_6 = vectortoangles(var_1);
  var_7 = anglesToForward(var_6);
  var_8 = anglestoright(var_6);
  var_9 = anglestoup(var_6);
  var_5.angles = axistoangles(var_8, var_9, var_7);
  var_5.owner = var_4;
  var_10 = var_4 getlaunchangles(var_0);

  if(isDefined(var_3) && isDefined(var_3.classname) && var_3.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0")
    var_3 = undefined;

  thread scripts\cp\powers\coop_molotov::molotov_stuck(var_5, var_3, var_10, var_2, 1);
}

getlaunchangles(var_0) {
  var_1 = vectorNormalize(var_0 - self.origin);
  var_2 = vectortoangles(var_1);
  var_3 = (0, self.angles[1], 0);
  var_4 = var_3 + (45, 0, 0);
  return var_4;
}

molotov_rebuild_angles_up_right(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_0, var_1));
  var_1 = vectorcross(var_2, var_0);
  return axistoangles(var_2, var_1, var_0);
}

molotov_rebuild_angles_up_forward(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_1, var_0));
  var_1 = vectorcross(var_0, var_2);
  return axistoangles(var_1, var_2, var_0);
}