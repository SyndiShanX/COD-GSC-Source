/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_pitcher.gsc
***********************************************/

function init() {
  foreach(var_1 in level.players) {
    thread firemanager();
  }
}

function firemanager() {
  self.offhands = spawnStruct();
  self.offhands.lastusedoffhandweapon = undefined;
  self.offhands.lastusedoffhandtime = 0;

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(var_1.basename == "iw8_la_mike32_mp") {
      thread watchforimpact(var_0);
    }
  }
}

function watchforimpact(var_0) {
  var_0.owner = self;
  var_0 endon("entitydeleted");
  var_1 = getmissileowner(var_0);
  var_0 waittill("explode", var_2, var_3, var_4, var_5);
  thread molotovexplode(var_2, var_3, var_4, var_5, var_1);
}

function molotovexplode(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_0);
  var_5 setModel("offhand_wm_molotov_mp");
  var_6 = vectortoangles(var_1);
  var_7 = anglesToForward(var_6);
  var_8 = anglestoright(var_6);
  var_9 = anglestoup(var_6);
  var_5.angles = axistoangles(var_8, var_9, var_7);
  var_5.owner = var_4;
  var_10 = getlaunchangles(var_4, var_0);

  if(isDefined(var_3) && isDefined(var_3.classname) && var_3.classname == "worldspawn") {
    var_3 = undefined;
  }

  thread scripts\cp\powers\coop_molotov::molotov_stuck(var_5, var_3, var_10, var_2, 1);
}

function getlaunchangles(var_0) {
  var_1 = vectorNormalize(var_0 - self.origin);
  var_2 = vectortoangles(var_1);
  var_3 = (0, self.angles[1], 0);
  var_4 = var_3 + (45, 0, 0);
  return var_4;
}

function molotov_rebuild_angles_up_right(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_0, var_1));
  var_1 = vectorcross(var_2, var_0);
  return axistoangles(var_2, var_1, var_0);
}

function molotov_rebuild_angles_up_forward(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_1, var_0));
  var_1 = vectorcross(var_0, var_2);
  return axistoangles(var_1, var_2, var_0);
}