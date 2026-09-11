/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_pitcher.gsc
***********************************************/

function init() {
  foreach(var1 in level.players) {
    thread firemanager();
  }
}

function firemanager() {
  self.offhands = spawnStruct();
  self.offhands.lastusedoffhandweapon = undefined;
  self.offhands.lastusedoffhandtime = 0;

  for(;;) {
    self waittill("missile_fire", var0, var1);

    if(var1.basename == "iw8_la_mike32_mp") {
      thread watchforimpact(var0);
    }
  }
}

function watchforimpact(var0) {
  var0.owner = self;
  var0 endon("entitydeleted");
  var1 = getmissileowner(var0);
  var0 waittill("explode", var2, var3, var4, var5);
  thread molotovexplode(var2, var3, var4, var5, var1);
}

function molotovexplode(var0, var1, var2, var3, var4) {
  var5 = spawn("script_model", var0);
  var5 setModel("offhand_wm_molotov_mp");
  var6 = vectortoangles(var1);
  var7 = anglesToForward(var6);
  var8 = anglestoright(var6);
  var9 = anglestoup(var6);
  var5.angles = axistoangles(var8, var9, var7);
  var5.owner = var4;
  var10 = getlaunchangles(var4, var0);

  if(isDefined(var3) && isDefined(var3.classname) && var3.classname == "worldspawn") {
    var3 = undefined;
  }

  thread scripts\cp\powers\coop_molotov::molotov_stuck(var5, var3, var10, var2, 1);
}

function getlaunchangles(var0) {
  var1 = vectorNormalize(var0 - self.origin);
  var2 = vectortoangles(var1);
  var3 = (0, self.angles[1], 0);
  var4 = var3 + (45, 0, 0);
  return var4;
}

function molotov_rebuild_angles_up_right(var0, var1) {
  var2 = vectorNormalize(vectorcross(var0, var1));
  var1 = vectorcross(var2, var0);
  return axistoangles(var2, var1, var0);
}

function molotov_rebuild_angles_up_forward(var0, var1) {
  var2 = vectorNormalize(vectorcross(var1, var0));
  var1 = vectorcross(var0, var2);
  return axistoangles(var1, var2, var0);
}