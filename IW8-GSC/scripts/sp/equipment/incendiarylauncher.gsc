/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\incendiarylauncher.gsc
*******************************************************/

function init() {
  thread firemanager();
}

function firemanager() {
  self.offhands = spawnStruct();
  self.offhands.lastusedoffhandweapon = undefined;
  self.offhands.lastusedoffhandtime = 0;

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(var_1.basename == "iw8_la_mike32_incendiary") {
      thread watchforimpact();
    }
  }
}

function watchforimpact() {
  self endon("entitydeleted");
  var_0 = getmissileowner(self);
  self waittill("explode", var_1, var_2, var_3, var_4);
  scripts\sp\equipment\molotov::molotovexplode(var_1, var_2, var_3, var_4, var_0);
}